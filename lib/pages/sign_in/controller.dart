import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nova_v2/common/entities/entities.dart';
import 'package:nova_v2/common/routes/names.dart';
import 'package:nova_v2/common/store/store.dart';
import 'package:nova_v2/common/widgets/toast.dart';
import 'state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

       //Signin with  Credentials
       final _gAuthentication =await user.authentication;
       final _credential = GoogleAuthProvider.credential(
         idToken: _gAuthentication.idToken,
         accessToken: _gAuthentication.accessToken
       );

       await FirebaseAuth.instance.signInWithCredential(_credential);

       String displayName = user.displayName ?? user.email;
       String email = user.email;
       String id = user.id;
       String photoUrl = user.photoUrl ?? "https://headrick.com.do/wp-content/uploads/2020/09/no-user-image-square.jpg";
       UserLoginResponseEntity userProfile = UserLoginResponseEntity();
       userProfile.email = email;
       userProfile.accessToken = id;
       userProfile.displayName = displayName;
       userProfile.photoUrl = photoUrl;

       UserStore.to.saveProfile(userProfile);

       
       //Save user data to firestore
       var userbase = await db.collection("users").withConverter(
           fromFirestore: UserData.fromFirestore,
           toFirestore: (UserData userData, options)=> userData.toFirestore(),
       ).where("id", isEqualTo: id).get();

       if(userbase.docs.isEmpty){
         final data = UserData(
           id: id,
           name: displayName,
           email: email,
           photourl: photoUrl,
           location: "",
           fcmtoken: "",
           addtime: Timestamp.now()
         );
         await db.collection("users").withConverter(
           fromFirestore: UserData.fromFirestore,
           toFirestore: (UserData userData, options)=> userData.toFirestore(),
         ).add(data);
       }
       toastInfo(msg: "Login Success");
       
       //Redirect to message page
       Get.offAndToNamed(AppRoutes.Application);

       

     }
   } catch (e) {
     toastInfo(msg: "Login Error");
     print(".........login error: $e");
   }
 }

 @override
  void onReady() {
    super.onReady();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if(user!= null){
          print("User is currently logged out");
        }else{
          print("User is  logged in");
        }
    });
  }
}