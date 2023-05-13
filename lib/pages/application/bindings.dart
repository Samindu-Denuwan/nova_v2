import 'package:get/get.dart';

import '../contact/controller.dart';
import 'controller.dart';


class ApplicationBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<ContactController>(() => ContactController());


  }

}