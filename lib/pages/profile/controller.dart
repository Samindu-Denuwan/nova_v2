import 'dart:convert';

import 'package:get/get.dart';
import 'package:nova_v2/common/entities/user.dart';
import 'package:nova_v2/common/routes/routes.dart';
import 'package:nova_v2/common/store/user.dart';
import 'state.dart';
import 'package:google_sign_in/google_sign_in.dart';


class ProfileController extends GetxController {
  final state = ProfileState();
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://googleapis.com/auth/contacts.readonly'
  ]
);

asyncLoadAllData() async{
  String profile = await UserStore.to.getProfile();
  if(profile.isNotEmpty){
    UserLoginResponseEntity userdata = UserLoginResponseEntity.fromJson(jsonDecode(profile));
    state.head_detail.value = userdata;
  }

}

Future <void> onLogOut() async{
  UserStore.to.onLogout();
  await _googleSignIn.signOut();
  Get.offAllNamed(AppRoutes.SIGN_IN);
}


  ProfileController();

@override
  void onInit() {
    super.onInit();
    asyncLoadAllData();

    List MyList = [
      {"name": "Account", "icon":"assets/icons/1.png", "route": "/account"},
      {"name": "Chat", "icon":"assets/icons/2.png", "route": "/chat"},
      {"name": "Notification", "icon":"assets/icons/3.png", "route": "/notification"},
      {"name": "Privacy", "icon":"assets/icons/3.png", "route": "/privacy"},
      {"name": "Help", "icon":"assets/icons/5.png", "route": "/help"},
      {"name": "About", "icon":"assets/icons/6.png", "route": "/about"},
      {"name": "Logout", "icon":"assets/icons/7.png", "route": "/logout"},
    ];

    for(int i =0; i<MyList.length; i++){
      MeListItem result = MeListItem();
      result.icon = MyList[i]["icon"];
      result.name = MyList[i]["name"];
      result.route = MyList[i]["route"];
      state.meListItem.add(result);

    }


  }

}



