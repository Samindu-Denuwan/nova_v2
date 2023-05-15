
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_v2/common/entities/entities.dart';
import 'package:nova_v2/common/entities/msgcontent.dart';
import 'package:nova_v2/common/store/store.dart';
import 'package:nova_v2/common/utils/utils.dart';
import 'package:nova_v2/common/widgets/toast.dart';
import 'state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ChatController extends GetxController {
  final state = ChatState();

  // void goMore(){
  //   state.more_status.value =state.more_status.value? false:true;
  // }

  ChatController();
  var doc_id =null;
  final textController = TextEditingController();
  ScrollController msgScrolling = ScrollController();
  FocusNode contentNode = FocusNode();
  final user_id = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  var listener;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  //get images from gallery
  Future imgFromGallery() async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      _photo = File(pickedFile.path);
      uploadFile();
    }else{
    print("No Image Select");
    }
  }

  Future getImgUrl(String name) async{
    final spaceRef = FirebaseStorage.instance.ref("Chat").child(name);
    var str = await spaceRef.getDownloadURL();
    return str??"";
  }

  //save image url in firestore
  sendImageMessage(String url) async{
    final content = Msgcontent(
      uid: user_id,
      content: url,
      type: "image",
      addtime: Timestamp.now()
    );
    await db.collection("messages").doc(doc_id).collection("msglist").
    withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msgcontent, options)=>msgcontent.toFirestore()
    ).add(content).then((DocumentReference doc) {
      print("Document snapshot added with id : ${doc_id}");
      textController.clear();
      Get.focusScope?.unfocus();
    });

    await db.collection("messages").doc(doc_id).update({
      "last_msg":"[image]",
      "last_time": Timestamp.now(),
    });


  }


  Future uploadFile() async{
    if(_photo == null) return;
    final fileName = getRandomString(15);
    try{
      final ref = FirebaseStorage.instance.ref("Chat").child(fileName);
      ref.putFile(_photo!).snapshotEvents.listen((event) async{
          switch(event.state){
            case TaskState.running:
            break;
            case TaskState.paused:
              break;

            case TaskState.success:
              String imgUrl = await getImgUrl(fileName);
              sendImageMessage(imgUrl);
          Get.snackbar("Image Delivered","Message Sent Successfuly!",
          icon: const Icon(Icons.photo_album, color: Colors.grey));
              break;
            case TaskState.canceled:

              break;
            case TaskState.error:

              break;
          }
      });

    }catch(e){
      print("There is an Error : ${e}");
    }
  }


  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    doc_id = data ['doc_id'];
    state.to_uid.value = data['to_uid']??"";
    state.to_name.value = data['to_name']??"";
    state.to_avatar.value = data['to_avatar']??"";

  }

  sendMessage() async{
    String sendContent = textController.text;
    if(sendContent==""){
      return;
    }else {
      Get.snackbar(" Message Delivered","Message Sent Successfuly!",
        icon: const Icon(Icons.message_rounded),
      );
      final content = Msgcontent(
        uid: user_id,
        content: sendContent,
        type: "text",
        addtime: Timestamp.now(),
      );

      await db.collection("messages").doc(doc_id).collection("msglist").
      withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent msgcontent, options) =>
              msgcontent.toFirestore()
      ).add(content).then((DocumentReference doc) {
        print("Document snapshot added with id : ${doc_id}");
        textController.clear();
        Get.focusScope?.unfocus();
      });

      await db.collection("messages").doc(doc_id).update({
        "last_msg": sendContent,
        "last_time": Timestamp.now(),
      });
    }
  }

  @override
  void onReady() {
    super.onReady();

   var messages = db.collection("messages").doc(doc_id).collection("msglist").withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msgcontent, options)=> msgcontent.toFirestore()
    ).orderBy("addtime", descending:false );
    state.msgcontentList.clear();
    listener = messages.snapshots().listen((event) {
      for(var change in event.docChanges){
        switch(change.type){
          case DocumentChangeType.added:
            if(change.doc.data()!=null){
              state.msgcontentList.insert(0, change.doc.data()!);

            }

            break;
          case DocumentChangeType.modified:
            break;
          case DocumentChangeType.removed:
            break;
        }
      }
    },
      onError: (error)=> print("Listen Failed: $error")
    );

    getLocation();
  }

  getLocation() async{
    try{
     var user_location = await db.collection("users").where("id",isEqualTo: state.to_uid.value).withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userdata, optons)=> userdata.toFirestore()).get();

      var location = user_location.docs.first.data().location;
      if(location!=""){
        print("location.............: $location");
        state.to_location.value=location??"unknown";
      }
    }catch(e){
      print("We have Location Error : $e");
    }
  }

  @override
  void dispose() {
    msgScrolling.dispose();
    listener.cancel();
    super.dispose();
  }

}



