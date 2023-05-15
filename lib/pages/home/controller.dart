import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:nova_v2/common/entities/entities.dart';
import 'package:nova_v2/common/store/store.dart';
import 'package:nova_v2/common/utils/http.dart';
import 'state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';



class MessageController extends GetxController {

  MessageController();
  final token = UserStore.to.token;
  final db =FirebaseFirestore.instance;
  final state = MessageState();
  var listener;

 final RefreshController refreshController = RefreshController(
      initialRefresh: true
      );

 @override
  void onReady() {
    super.onReady();
    getUserLocation();
  }


 void onRefresh(){
   asyncLoadAllData().then((_){
     refreshController.refreshCompleted(resetFooterState: true);
   }).catchError((_){
     refreshController.refreshFailed();
   });
 }

 void onLoading(){
   asyncLoadAllData().then((_){
     refreshController.refreshCompleted(resetFooterState: true);
   }).catchError((_){
     refreshController.refreshFailed();
   });
 }


 asyncLoadAllData() async{
  var from_messages =  await db.collection("messages").withConverter(
       fromFirestore: Msg.fromFirestore,
       toFirestore: (Msg msg, options)=>msg.toFirestore()).where(
       "from_uid", isEqualTo: token
   ).get();

 var to_messages =  await db.collection("messages").withConverter(
      fromFirestore: Msg.fromFirestore,
      toFirestore: (Msg msg, options)=>msg.toFirestore()).where(
      "to_uid", isEqualTo: token
  ).get();

 state.msgList.clear();
 if(from_messages.docs.isNotEmpty){
   state.msgList.assignAll((from_messages.docs));
 }

 if(to_messages.docs.isNotEmpty){
   state.msgList.assignAll((to_messages.docs));
 }

 }

 getUserLocation()async{
   try{
    final location = await Location().getLocation();
    String address = "${location.latitude},${location.longitude}";
    String url = "https://googleapis.com/maps/api/geocode/json?address = ${address}&key=AIzaSyCeYbGhV_eqJ9YVGIMuhMhi-tbXyYkTET8";
    var response = await HttpUtil().get(url);
    MyLocation location_res = MyLocation.fromJson(response);
    if(location_res.status=="OK"){
      String? myadress = location_res.results?.first.formattedAddress;
      if(myadress!=null){
        var user_location = await db.collection("users").where("id", isEqualTo: token).get();
        if(user_location.docs.isNotEmpty){
          var doc_id = user_location.docs.first.id;
          await db.collection("users").doc(doc_id).update({
            "location": myadress
          });
        }
      }
    }

   }catch(e){
     print("Getting Location Error $e");
   }
 }




}



