import 'package:get/get.dart';
import 'package:nova_v2/pages/welcome/controller.dart';

class WelcomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }

}