import 'package:bot_toast/bot_toast.dart';
import 'package:delivery_boy/controller/controller_auth.dart';
import 'package:delivery_boy/values/export.dart';
import 'package:delivery_boy/view/custom_widget/custom_dialoug.dart';
import 'package:delivery_boy/view/main_screen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart' as getx;

class ServerAuth {
  ServerAuth._();
  static ServerAuth instance = ServerAuth._();
  Dio? dio;
  AppController appController = getx.Get.find();
  AuthController authController = getx.Get.find();

  initApi() {
    if (dio == null) {
      dio = Dio();
      return dio;
    } else {
      return dio;
    }
  }
  ///////////////////////////////////////////////////////////////////

  register({
    String? name,
    String? email,
    String? password,
    String? confirmationPassword,
  }) async {
    initApi();
    BotToast.showLoading();

    try {
      Response response = await dio!.post(url + 'signup', data: {
        "email": email,
        "password": password,
        "password_confirmation": confirmationPassword,
        "name": name,
      }, options: Options(
        validateStatus: (status) {
          return status! < 500;
        },
      ));
      BotToast.closeAllLoading();
      if (response.data['status'] == 200) {
        authController.password = password;
        await SHelper.sHelper.setToken(response.data["data"]['token']);
        appController.token = response.data["data"]['token'];
        // getx.Get.to(() => AddPhoneScreen());
      } else {
        getx.Get.snackbar(
          response.data['message'],
          "",
        );
      }
    } catch (e) {
      BotToast.closeAllLoading();
      getx.Get.snackbar(
        "Register Faild",
        "",
      );
    }
  }

  /////////////////////////////////////////////////////////////
  login({String? mobile, String? password}) async {
    initApi();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? fcmToken = await firebaseMessaging.getToken();
    await SHelper.sHelper.setFcmToken(fcmToken!);
    try {
      BotToast.showLoading();

      Response response = await dio!.post(
        url + 'user/login',
        data: {
          "mobile": mobile,
          "password": password,
          "fcm_token": fcmToken,
        },
      );
      BotToast.closeAllLoading();
      if (response.data['code'] == 200) {
        appController.token = response.data['accessToken'];
        await SHelper.sHelper.setToken(response.data['accessToken']);
        await SHelper.sHelper.addNew('name', response.data["user"]['name']);
        await SHelper.sHelper.addNew('mobile', response.data["user"]['mobile']);
        await SHelper.sHelper
            .addNew('address', response.data["user"]['address']);
        BotToast.closeAllLoading();

        await appController.getApi();
      } else {
        getx.Get.snackbar(
          "Login Faild",
          response.data['message'],
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      BotToast.closeAllLoading();
      getx.Get.snackbar(
        "Login Faild",
        "Error",
        duration: Duration(seconds: 3),
      );
    }
  }
///////////////////////////////////////////////////////////////////

  verifyMobile({required String mobileNumber, int? type}) async {
    initApi();
    String newMobile;

    if (mobileNumber.substring(0, 1) == "0") {
      newMobile = mobileNumber.substring(1);
    } else {
      newMobile = mobileNumber;
    }

    try {
      appController.pr.show(message: '');

      Response response = await dio!.post(url + 'activeMobile',
          data: {
            "mobile": "0047" + newMobile,
          },
          options: Options(headers: {
            'Authorization': 'Bearer ${SHelper.sHelper.getToken()}'
          }));
      appController.pr.hide();
      authController.code = response.data["data"]["code"];
      if (type == 1) {
      } else {
        // getx.Get.to(() => VerificationScreen());
      }
    } catch (e) {
      appController.pr.hide();

      getx.Get.snackbar(
        "mobile Faild",
        "",
        duration: Duration(seconds: 3),
      );
    }
  }

///////////////////////////////////////////////////////////////////

  sendCode(String code, int type) async {
    initApi();

    appController.pr.show(message: '');
    try {
      Response response = await dio!.post(url + 'activeCode',
          data: {
            "code": code,
          },
          options: Options(headers: {
            'Authorization': 'Bearer ${SHelper.sHelper.getToken()}'
          }));
      appController.pr.hide();

      if (response.data["status"] == 200) {
        if (type == 1) {
          getx.Get.back();
          // setToast("Mobilnummeret er endret", Colors.green);
        } else {
          await appController.getApi();
          appController.indexNav.value = 0;
          getx.Get.offAll(() => MainScreen());
        }
      } else {
        getx.Get.snackbar(
          response.data["message"],
          "",
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      appController.pr.hide();
      getx.Get.snackbar(
        "mobile Faild",
        "",
        duration: Duration(seconds: 3),
      );
    }
  }

////////////////////////////////////////////////////////////////////
  forgetPassword({String? email}) async {
    initApi();
    appController.pr.show(message: '');
    try {
      await dio!.post(
        url + 'change-password',
        data: {
          "email": email,
        },
      );
      appController.pr.hide();

      // setToast("Passordet er sendt", Colors.green);
    } catch (e) {
      appController.pr.hide();

      CustomDialougs.utils.showDialoug(messageKey: 'error', titleKey: 'error');
    }
  }

////////////////////////////////////////////////////////////////////
  deactivate(String password) async {
    initApi();
    appController.pr.show(message: '');
    try {
      var response = await dio!.post(
        url + 'deactivate',
        data: {
          "password": password,
        },
      );

      await SHelper.sHelper.clearSp();
      if (response.data["success"] == null) {
        CustomDialougs.utils
            .showDialoug(messageKey: response.data["error"], titleKey: 'error');
      } else {
        // setToast(response.data["success"], Colors.red);
        // getx.Get.offAll(() => LogInScreen());
        appController.pr.hide();
      }
    } catch (e) {
      appController.pr.hide();

      CustomDialougs.utils.showDialoug(messageKey: "", titleKey: 'error');
    }
  }
}
