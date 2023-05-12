import 'package:get/get.dart';
import 'package:nova_v2/common/routes/names.dart';
import 'package:nova_v2/common/store/store.dart';
import 'state.dart';

class WelcomeController extends GetxController{
  final state = WelcomeState();
  WelcomeController();

  changePage(int index) async{
    state.index.value = index;
  }

  handleSignIn() async{
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }

}