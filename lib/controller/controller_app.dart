import 'package:delivery_boy/server/server_order.dart';

import 'package:delivery_boy/values/export.dart';
import 'package:delivery_boy/view/main_screen.dart';
import 'package:delivery_boy/view/screen/auth_screen/logIn_screen.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import 'controller_profile.dart';

class AppController extends GetxController {
  RxInt indexNav = 0.obs;
  String? token;

  // var pr = ProgressDialogUtils.createProgressDialog(Get.context);
  SimpleFontelicoProgressDialog pr = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);
  ProfileController profileController = Get.find();

  getApi() async {
    if (SHelper.sHelper.getToken() != null) {
      SHelper.sHelper.getFcmToken()!;
      await ServerOrder.instance.getOrders();
      ServerOrder.instance.getOrderFinish(DateTime.now().toString());
      Get.offAll(() => MainScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  ///////////////////////////////////////////
  int indexHomeScreen = 0;
  setIndexHome(int value) {
    this.indexHomeScreen = value;
    update();
  }
}
