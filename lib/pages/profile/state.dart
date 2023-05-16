import 'package:get/get.dart';
import 'package:nova_v2/common/entities/entities.dart';

class ProfileState{
var head_detail = Rx<UserLoginResponseEntity?>(null);
RxList<MeListItem> meListItem = <MeListItem>[].obs;
}