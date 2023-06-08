import 'package:delivery_boy/server/server_auth.dart';
import 'package:delivery_boy/values/export.dart';
import 'package:delivery_boy/view/custom_widget/customTextField.dart';
import 'package:delivery_boy/view/custom_widget/custom_button.dart';
import 'package:delivery_boy/view/custom_widget/custom_dialoug.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();

  setNumberValidator(String value) {
    if (value.length < 9) {
      return "رقم الهاتف خطا";
    }
  }

  setPasswordValidator(String value) {
    if (value.isEmpty) {
      return "كلمة المرور خطا";
    }
  }

  saveForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // if (ConnectivityService.connectivityStatus !=
      //     ConnectivityStatus.Offline) {
      await ServerAuth.instance
          .login(mobile: number.text, password: password.text);
      // } else {
      //   CustomDialougs.utils
      //       .showDialoug(messageKey: 'network_error', titleKey: 'alert');
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        FadeInRight(
                            duration: Duration(milliseconds: 2000),
                            child: Container(
                                height: 150,
                                width: 250,
                                child: Image.asset(
                                  "assets/images/van.gif",
                                  fit: BoxFit.fill,
                                ))),
                        Container(
                            height: 10.h,
                            alignment: Alignment.center,
                            child: Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                color: Color(0xff658199),
                                fontFamily: 'Cairo',
                                fontSize: 20.0,
                              ),
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        CustomTextFormField(
                            hintText: 'رقم الموبايل',
                            textEditingController: number,
                            textInputType: TextInputType.phone,
                            validator: setNumberValidator,
                            prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.person))),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormField(
                          hintText: 'كلمة المرور',
                          password: true,
                          textEditingController: password,
                          validator: setPasswordValidator,
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.lock)),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        CustomButton(
                          height: 55.h,
                          width: 200.w,
                          onTap: () => saveForm(),
                          text: "تسجيل الدخول",
                          colorText: AppColors.white,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
