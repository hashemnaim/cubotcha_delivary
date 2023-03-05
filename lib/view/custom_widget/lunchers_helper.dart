import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class LuncherHelper {
  LuncherHelper._internal();
  static final LuncherHelper validationHelper = LuncherHelper._internal();

  void launchURL(String url) async {
    await launchUrl(Uri.parse(url));
    throw 'Could not launch $url';
  }

  void launchEmailURL(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(params);

    throw 'Could not launch $params';
  }

  void launchWhatsApp({
    String? phone,
    String? message,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "https://wa.me/+2$phone/?text=${Uri.parse(message!)}";
      } else {
        return "whatsapp://send?phone=+2" + phone! + "&text= ";
      }
    }

    await launchUrl(Uri.parse(url()));
    throw 'Could not launch $url';
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  Future<void> launchInBrowser(Uri url) async {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
  // void openMyAppInStore(BuildContext context) async {
  //   try {
  //     String storeLink = "";
  //     if (Platform.isIOS) {
  //       storeLink = "https://asalni.page.link/asalni-ios";
  //     } else {
  //       storeLink = "https://asalni.page.link/asalnii";
  //     }
  //     final size = MediaQuery.of(context).size;
  //     Share.share(storeLink,
  //         sharePositionOrigin: Rect.fromLTWH(0, 0, size.width, size.height / 2),
  //         subject: "قم بمشاركة التطبيق");
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

