import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nova_v2/common/entities/msgcontent.dart';
import 'package:nova_v2/common/store/store.dart';
import 'state.dart';



class ChatController extends GetxController {
  final state = ChatState();

  void goMore(){
    state.more_status.value =state.more_status.value? false:true;
  }

  ChatController();
  var doc_id =null;
  final textController = TextEditingController();
  ScrollController msgScrolling = ScrollController();
  FocusNode contentNode = FocusNode();
  final user_id = UserStore.to.token;
  final db = FirebaseFirestore.instance;

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
    final content = Msgcontent(
      uid: user_id,
      content: sendContent,
      type: "text",
      addtime: Timestamp.now(),
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
      "last_msg":sendContent,
      "last_time": Timestamp.now(),
    });
  }

}



