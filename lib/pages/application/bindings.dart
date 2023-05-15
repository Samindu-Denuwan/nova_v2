import 'package:get/get.dart';
import 'package:nova_v2/pages/home/controller.dart';

import '../contact/controller.dart';
import 'controller.dart';


class ApplicationBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<ContactController>(() => ContactController());
    Get.lazyPut<MessageController>(() => MessageController());


  }

}