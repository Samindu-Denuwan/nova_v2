import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nova_v2/common/entities/entities.dart';
import 'package:nova_v2/common/store/store.dart';
import 'state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'openid'
  ]
);

class SignInController extends GetxController{
  final state = SignInState();
  SignInController();
  final db = FirebaseFirestore.instance;
 Future<void> handleSignIn() async {
   try {
     var user = await _googleSignIn.signIn();
     if (user != null) {
       String displayName = user.displayName ?? user.email;
       String email = user.email;
       String id = user.id;
       String photoURL = user.photoUrl ?? "";
       UserLoginResponseEntity userProfile = UserLoginResponseEntity();
       userProfile.email = email;
       userProfile.accessToken = id;
       userProfile.displayName = displayName;
       userProfile.photoUrl = photoURL;

       UserStore.to.saveProfile(userProfile);
       Fluttertoast.showToast(
           msg: "Login Success, user: $email",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
     }
   } catch (e) {
     Fluttertoast.showToast(
         msg: "$e",
         toastLength: Toast.LENGTH_LONG,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 16.0
     );
   }
 }
}