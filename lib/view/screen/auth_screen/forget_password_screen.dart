import 'package:delivery_boy/values/export.dart';

import '../../../values/styles.dart';
import '../../custom_widget/AppCustomer.dart';
import '../../custom_widget/background.dart';
import '../../custom_widget/custom_button.dart';

class ForgetScreen extends StatefulWidget {
  @override
  _ProdactScreenState createState() => _ProdactScreenState();
}

class _ProdactScreenState extends State<ForgetScreen>
    with SingleTickerProviderStateMixin {
//List<DataProdacts> dataProdacts=[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getTap();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: AppCustomer(
              "نسيت كلمة المرور",
            ),
            preferredSize: const Size(double.infinity, 60),
          ),
          //resizeToAvoidBottomInset: false,
          body: Container(
              child: Column(children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Bakeground(),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(

                            // padding: EdgeInsets.only(right: 20),
                            height: 60,
                            width: 300,
                            child: TextFormField(
                                textAlign: TextAlign.center,
                                onChanged: (value) async {},
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "ادخل البريد الكتروني ",
                                    hintStyle: rubikBold.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white)),
                        SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: "ارسال",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ])),
        ),
      ),
    );
  }
}
