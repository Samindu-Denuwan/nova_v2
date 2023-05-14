import 'package:get/get.dart';

import '../home/controller.dart';


class MessageBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(() =>MessageController());


  }

}