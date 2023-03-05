import 'package:bot_toast/bot_toast.dart';
import 'package:delivery_boy/controller/controller_auth.dart';
import 'package:delivery_boy/controller/controller_order.dart';
import 'package:delivery_boy/print/invoice_settings.controller.dart';
import 'package:delivery_boy/splash.dart';
import 'package:delivery_boy/values/export.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'controller/controller_categorie.dart';
import 'controller/controller_profile.dart';
import 'helper/fcm_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SHelper.sHelper.initSharedPrefrences();
  await FcmHelper.fcmHelper.initFcm();

  // await NotificationHelper().initialNotification();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Get.lazyPut(() => AppController(), fenix: false);
    Get.lazyPut(() => AuthController(), fenix: false);
    Get.put(InvoiceSettingsController());
    Get.put(OrderController());

    Get.lazyPut(() => CategorieController(), fenix: false);
    Get.lazyPut(() => ProfileController(), fenix: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        precacheImage(AssetImage('assets/images/background.png'), context);
        precacheImage(AssetImage('assets/images/im1.png'), context);
        precacheImage(AssetImage('assets/images/im2.png'), context);
        precacheImage(AssetImage('assets/images/im3.png'), context);
        precacheImage(AssetImage('assets/images/loginBackground.png'), context);
        precacheImage(
            AssetImage('assets/images/login2Background.png'), context);

        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            locale: Locale("ar"),
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            home: Splash());
      },
    );
  }
}
