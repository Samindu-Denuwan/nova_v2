import 'package:get/get.dart';
import 'package:nova_v2/common/entities/entities.dart';

class ContactState{
  var count = 0.obs;
  RxList<UserData> contactList = <UserData>[].obs;
}