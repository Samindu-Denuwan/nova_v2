import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nova_v2/common/entities/entities.dart';
import 'package:nova_v2/common/entities/user.dart';
import 'package:nova_v2/common/store/store.dart';
import 'state.dart';

class ContactController extends GetxController {
  final state = ContactState();

  ContactController();
  //user data
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

  @override
  void onReady(){
    super.onReady();
    asyncLoadAllData();
  }

  goChat(UserData to_userdata) async{
   var from_messages = await db.collection("messages").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, option)=>msg.toFirestore()).where(
      "from_uid", isEqualTo: token
    ).where(
      "to_uid", isEqualTo: to_userdata.id
    ).get();

   var to_messages = await db.collection("messages").withConverter(
       fromFirestore: Msg.fromFirestore,
       toFirestore: (Msg msg, option)=>msg.toFirestore()).where(
       "from_uid", isEqualTo: to_userdata.id
   ).where(
       "to_uid", isEqualTo: token
   ).get();

   if(from_messages.docs.isEmpty && to_messages.docs.isEmpty){
     String profile = await UserStore.to.getProfile();
     UserLoginResponseEntity userdata =
     UserLoginResponseEntity.fromJson(jsonDecode(profile));

     Msg(
       from_uid: userdata.accessToken,
       to_uid: to_userdata.id,

     );
   }


  }

  asyncLoadAllData()async {
  var usersbase = await db
        .collection("users")
      .where("id", isNotEqualTo: token)
        .withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userdata, options) => userdata.toFirestore())
        .get();

  for(var doc in usersbase.docs ){
    state.contactList.add(doc.data());
    print(doc.toString());
  }
  }
}
