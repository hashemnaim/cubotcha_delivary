import 'package:delivery_boy/controller/controller_order.dart';
import 'package:delivery_boy/values/dimensions.dart';
import 'package:delivery_boy/values/export.dart';
import 'package:delivery_boy/view/screen/auth_screen/logIn_screen.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage("assets/images/background.png"),
                      fit: BoxFit.fill)),
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              // color: Theme.of(context).primaryColor,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  _userInfoWidget(
                      context: context, text: SHelper.sHelper.getValue("name")),
                  SizedBox(height: 15),
                  _userInfoWidget(
                      context: context,
                      text: SHelper.sHelper.getValue("mobile")),
                  SizedBox(height: 15),
                  // _userInfoWidget(
                  //     context: context,
                  //     text: SHelper.sHelper.getValue("address")),
                  // SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      await SHelper.sHelper.clearSp();
                      Get.offAll(() => LoginScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          CustomPngImage(
                            "log_out",
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(width: 19),
                          CustomText(
                            text: 'تسجيل الخروج',
                            fontSize: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _userInfoWidget({String? text, required BuildContext context}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 22),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
          color: Theme.of(context).cardColor,
          border: Border.all(color: AppColors.blackLight)),
      child: Text(
        text ?? '',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
