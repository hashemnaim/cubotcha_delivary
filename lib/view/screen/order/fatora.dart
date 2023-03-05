// import 'package:date_time_picker/date_time_picker.dart' as piker;
import 'package:delivery_boy/values/export.dart';
import 'package:delivery_boy/view/screen/order/widget/custom_divider.dart';
import 'package:intl/intl.dart' as i;
import '../../../model/detailsProduct_model.dart';
import '../../../values/dimensions.dart';
import '../../../values/styles.dart';

class FatoraScreen extends StatelessWidget {
  final Orders? order;

  FatoraScreen({this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Container(
                      width: 180, height: 50, child: CustomPngImage("im3"))),
              CustomText(
                text: "***************************************",
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: "رقم الفاتورة : ${order!.code}",
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: "اسم المستخدم : هاشم",
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: "التاريخ : ${order!.date}",
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: "الوقت : ${order!.time}",
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: "***************************************",
                fontWeight: FontWeight.bold,
              ),
              Row(children: [
                CustomText(
                  text: "Time : " +
                      i.DateFormat('kk:mm').format(DateTime.now()).toString(),
                  fontWeight: FontWeight.bold,
                ),
                Spacer(),
                CustomText(
                  text: "Date : " +
                      i.DateFormat('EEE, M/d/y')
                          .format(DateTime.now())
                          .toString(),
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text: "كاش",
                  fontWeight: FontWeight.bold,
                ),
              ]),
              SizedBox(height: 2),
              Divider(),
              if (order!.products!.length == 0)
                Container()
              else
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  itemCount: order!.products!.length,
                  itemBuilder: (context, index2) {
                    return ListTile(
                      trailing: Text(
                          order!.products![index2].price.toString() + " جنيه",
                          style: rubikMedium.copyWith(fontSize: 14.sp)),
                      leading: SizedBox(
                        width: 140.w,
                        child: Row(
                          children: [
                            SizedBox(width: 4.w),
                            Container(
                              width: 90.w,
                              child: Text(order!.products![index2].name!,
                                  style: rubikMedium.copyWith(fontSize: 14.sp)),
                            ),
                          ],
                        ),
                      ),
                      title: Text(
                        " ${order!.products![index2].quantity} X",
                        style: rubikMedium.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        ),
                      ),
                    );
                  },
                ),
              SizedBox(height: 8.h),
              // CustomDivider(),
              SizedBox(height: 8.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('مجموع المنتجات',
                    style: rubikMedium.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                    )),
                Text(order!.totalPrice.toString() + " جنيه",
                    style: rubikMedium.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                    )),
              ]),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                CustomText(
                  text: 'رسوم التوصيل',
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
                CustomText(
                  text: '${order!.deliveryCost.toString()} جنيه',
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
              ]),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_SMALL),
                child: CustomDivider(),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                CustomText(
                  text: 'المبلغ الاجمالي',
                  fontSize: 20,
                ),
                CustomText(
                  text: (double.parse(order!.totalPrice!) +
                              double.parse(order!.deliveryCost!))
                          .toString() +
                      " جنيه",
                  fontSize: 20,
                ),
              ]),
              SizedBox(height: 8.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    child: CustomText(
                      text: "اي استفسار التواصل على رقم ",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  CustomText(
                    text: "ORIGINAL COPY",
                    fontWeight: FontWeight.bold,
                  ),
                  Spacer(),
                  CustomText(
                    text: "نسخة اصليه",
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
