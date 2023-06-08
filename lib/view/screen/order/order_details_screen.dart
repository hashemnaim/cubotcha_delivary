import 'dart:math';
import 'package:delivery_boy/controller/controller_order.dart';
import 'package:delivery_boy/values/dimensions.dart';
import 'package:delivery_boy/values/export.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';
import '../../../helper/method_helpar.dart';
import '../../../model/order_modal.dart';
import '../../../server/server_order.dart';
import '../../../values/styles.dart';
import '../../custom_widget/custom_image_Network.dart';
import '../../main_screen.dart';
import '../home/widget/order_widget.dart';
import 'widget/custom_divider.dart';
import 'widget/delivery_dialog.dart';
import 'widget/permission_dialog.dart';
import 'widget/slider_button.dart';

class OrderDetailsScreen extends StatefulWidget {
  final User? user;
  final int index;

  OrderDetailsScreen({
    this.user,
    required this.index,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // orderController.begin.value = false;
    // SunmiPrinter.bindingPrinter();
  }

  @override
  Widget build(BuildContext context) {
    OrderController orderController = Get.find();

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            actions: [
              IconButton(
                icon: Icon(Icons.refresh,
                    color: Theme.of(context).textTheme.bodyText1!.color),
                onPressed: () {
                  ServerOrder.instance.getOrders();
                },
              ),
              // IconButton(
              //   icon: Icon(Icons.print,
              //       color: Theme.of(context).textTheme.bodyText1!.color),
              //   onPressed: () async {
              //     orderController
              //         .printSunmi(orderController.detailsProdact.value.orders!);
              //     // orderController.invoiceBuilder(
              //     //     orderController.detailsProdact.value.orders!);
              //   },
              // ),
            ],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            centerTitle: true,
            title: CustomPngImage(
              "im3",
              height: 60,
              width: 100,
            )),
        body: Obx(() {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage("assets/images/background.png"),
                    fit: BoxFit.fill)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    children: [
                      CustomText(
                        text:
                            ' # ${orderController.detailsProdact.value.orders!.code}',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      orderController.detailsProdact.value.orders!.notes == null
                          ? Container()
                          : CustomText(
                              text:
                                  '${orderController.detailsProdact.value.orders!.notes ?? ""}',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                      Row(children: [
                        Row(children: [
                          Container(
                              height: 10.h,
                              width: 10.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary)),
                          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          CustomText(
                              text:
                                  'تاريخ : ${orderController.detailsProdact.value.orders!.date}',
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color),
                        ]),
                        Spacer(),
                        Row(children: [
                          Container(
                              height: 10.h,
                              width: 10.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary)),
                          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          CustomText(
                              text:
                                  'الفترة : ${getPeriod(orderController.detailsProdact.value.orders!.time!)}',
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color),
                        ]),
                        SizedBox(width: 4.w)
                      ]),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                CustomText(
                                    text: '${widget.user!.name ?? ''}',
                                    color: AppColors.bluColor,
                                    fontSize: Dimensions.FONT_SIZE_LARGE),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    launch('tel:${widget.user!.mobile ?? ""}');
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.call_outlined,
                                        color: AppColors.bluColor,
                                      ),
                                      CustomText(
                                          text: ' ${widget.user!.mobile ?? ''}',
                                          color: AppColors.bluColor,
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT),
                                    ],
                                  ),
                                ),
                              ]),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.location_on,
                                        color: AppColors.primary, size: 30.sp),
                                    onPressed: () async {
                                      var position =
                                          await Geolocator.getCurrentPosition();

                                      MapUtils.openMap(
                                          double.parse(orderController
                                              .detailsProdact
                                              .value
                                              .orders!
                                              .address!
                                              .lat!),
                                          double.parse(orderController
                                              .detailsProdact
                                              .value
                                              .orders!
                                              .address!
                                              .lng!),
                                          position.latitude,
                                          position.longitude);
                                    },
                                  ),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: orderController.detailsProdact
                                                      .value.orders!.address !=
                                                  null
                                              ? orderController
                                                      .detailsProdact
                                                      .value
                                                      .orders!
                                                      .address!
                                                      .city! +
                                                  " - " +
                                                  orderController
                                                      .detailsProdact
                                                      .value
                                                      .orders!
                                                      .address!
                                                      .area!
                                              : 'العنوان غير موجود',
                                          fontSize: 14.sp,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color),
                                      orderController.detailsProdact.value
                                                  .orders!.address !=
                                              null
                                          ? Container()
                                          : CustomText(
                                              text: orderController
                                                      .detailsProdact
                                                      .value
                                                      .orders!
                                                      .address!
                                                      .street ??
                                                  "",
                                              fontSize: 14.sp,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color),
                                      CustomText(
                                          text: orderController.detailsProdact
                                                      .value.orders!.address !=
                                                  null
                                              ? "البناية  : " +
                                                  orderController
                                                      .detailsProdact
                                                      .value
                                                      .orders!
                                                      .address!
                                                      .building! +
                                                  "\t " +
                                                  "شقة  : " +
                                                  orderController
                                                      .detailsProdact
                                                      .value
                                                      .orders!
                                                      .address!
                                                      .apartment!
                                              : 'العنوان غير موجود',
                                          fontSize: 14.sp,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color),
                                    ],
                                  )),
                                ],
                              ),
                            ]),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Text('عدد المنتجات :', style: rubikMedium),
                            SizedBox(
                                width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            Text(
                              orderController
                                  .detailsProdact.value.orders!.products!.length
                                  .toString(),
                              style: rubikMedium.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                            )
                          ]),
                          Row(children: [
                            Text('طريقة الدفع :', style: rubikMedium),
                            Text('كاش', style: rubikMedium),
                          ])
                        ],
                      ),
                      Divider(height: 8.h),
                      if (orderController
                              .detailsProdact.value.orders!.products!.length ==
                          0)
                        Container()
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          primary: false,
                          itemCount: orderController
                              .detailsProdact.value.orders!.products!.length,
                          itemBuilder: (context, index2) {
                            return ListTile(
                              trailing: Text(
                                  (double.parse(orderController
                                                  .detailsProdact
                                                  .value
                                                  .orders!
                                                  .products![index2]
                                                  .price!) *
                                              double.parse(orderController
                                                  .detailsProdact
                                                  .value
                                                  .orders!
                                                  .products![index2]
                                                  .quantity!))
                                          .toStringAsFixed(1) +
                                      " جنيه",
                                  style: rubikMedium.copyWith(fontSize: 14.sp)),
                              leading: SizedBox(
                                width: 140.w,
                                child: Row(
                                  children: [
                                    CustomNetworkImage(
                                      imgUrl +
                                          orderController.detailsProdact.value
                                              .orders!.products![index2].image!,
                                      borderRadius: 0,
                                      width: 40.w,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(width: 4.w),
                                    Container(
                                      width: 90.w,
                                      child: Text(
                                          orderController.detailsProdact.value
                                              .orders!.products![index2].name!,
                                          style: rubikMedium.copyWith(
                                              fontSize: 14.sp)),
                                    ),
                                  ],
                                ),
                              ),
                              title: Text(
                                orderController.detailsProdact.value.orders!
                                    .products![index2].quantity!,
                                style: rubikMedium.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                ),
                              ),
                            );
                          },
                        ),
                      if (orderController
                              .detailsProdact.value.orders!.cartons!.length ==
                          0)
                        Container()
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          primary: false,
                          itemCount: orderController
                              .detailsProdact.value.orders!.cartons!.length,
                          itemBuilder: (context, index2) {
                            return ListTile(
                              trailing: Text(
                                  orderController.detailsProdact.value.orders!
                                          .cartons![index2].cartonPrice
                                          .toString() +
                                      " جنيه",
                                  style: rubikMedium.copyWith(fontSize: 14.sp)),
                              leading: SizedBox(
                                width: 140.w,
                                child: Row(
                                  children: [
                                    CustomNetworkImage(
                                      imgUrl +
                                          orderController.detailsProdact.value
                                              .orders!.cartons![index2].image!,
                                      borderRadius: 0,
                                      width: 40.w,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(width: 4.w),
                                    Container(
                                      width: 90.w,
                                      child: Text(
                                          orderController
                                              .detailsProdact
                                              .value
                                              .orders!
                                              .cartons![index2]
                                              .cartonName!,
                                          style: rubikMedium.copyWith(
                                              fontSize: 14.sp)),
                                    ),
                                  ],
                                ),
                              ),
                              title: Text(
                                " ${orderController.detailsProdact.value.orders!.products![index2].quantity}",
                                style: rubikMedium.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                ),
                              ),
                            );
                          },
                        ),
                      SizedBox(height: 8.h),
                      CustomDivider(),
                      SizedBox(height: 8.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('مجموع المنتجات',
                                style: rubikMedium.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                )),
                            Text(
                                (double.parse(orderController
                                                    .detailsProdact
                                                    .value
                                                    .orders!
                                                    .discount_price ??
                                                "0") +
                                            double.parse(orderController
                                                    .detailsProdact
                                                    .value
                                                    .orders!
                                                    .totalPrice ??
                                                "0"))
                                        .toStringAsFixed(2) +
                                    " جنيه",
                                style: rubikMedium.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                )),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'الخصم',
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                            CustomText(
                              text:
                                  '${orderController.detailsProdact.value.orders!.discount_price} جنيه',
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: 'رسوم التوصيل',
                                fontSize: Dimensions.FONT_SIZE_LARGE),
                            CustomText(
                                text:
                                    '${orderController.detailsProdact.value.orders!.deliveryCost.toString()} جنيه',
                                fontSize: Dimensions.FONT_SIZE_LARGE),
                          ]),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.PADDING_SIZE_SMALL),
                        child: CustomDivider(),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'المبلغ الاجمالي',
                              fontSize: 20,
                            ),
                            CustomText(
                              text: (double.parse(orderController.detailsProdact
                                              .value.orders!.totalPrice!) +
                                          double.parse(orderController
                                              .detailsProdact
                                              .value
                                              .orders!
                                              .deliveryCost!))
                                      .toString() +
                                  " جنيه",
                              fontSize: 20,
                            ),
                          ]),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
                orderController.detailsProdact.value.orders!.statusCode
                            .toString() ==
                        "2"
                    ? Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_SMALL),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.gray,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 1))
                          ],
                          border:
                              Border.all(color: AppColors.gray.withOpacity(.8)),
                        ),
                        child: Transform.rotate(
                          angle: pi * 2, // in radians
                          child: Directionality(
                            textDirection: TextDirection.ltr, // set it to rtl
                            child: SliderButton(
                              action: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: DeliveryDialog(
                                          onTap: () async {
                                            await ServerOrder.instance
                                                .changeStatus(
                                                    orderController
                                                        .detailsProdact
                                                        .value
                                                        .orders!
                                                        .orderId,
                                                    widget.user!.fcmToken!);
                                            Get.to(() => MainScreen());
                                          },
                                          title: 'المبلغ المستحق ',
                                          index: widget.index,
                                          totalPrice: (double.parse(
                                                  orderController
                                                      .detailsProdact
                                                      .value
                                                      .orders!
                                                      .totalPrice!) +
                                              double.parse(orderController
                                                  .detailsProdact
                                                  .value
                                                  .orders!
                                                  .deliveryCost!)),
                                        ),
                                      );
                                    });

                                // }
                              },

                              ///Put label over here
                              label: Text(
                                'قم بالسحب لإنهاء عميلة التوصيل',
                                style: rubikBold.copyWith(
                                    fontSize: 18, color: AppColors.gray),
                              ),
                              dismissThresholds: 0.5,
                              dismissible: false,
                              icon: Center(
                                  child: Icon(
                                Icons.double_arrow_sharp,
                                color: Colors.white,
                                size: 16.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              )),

                              radius: 10,
                              boxShadow: BoxShadow(blurRadius: 0.0),
                              buttonColor: AppColors.blackDark,
                              backgroundColor: AppColors.white,
                              baseColor: AppColors.primary,
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          );
        }));
  }

  void checkPermission(BuildContext context, Function callback) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      showDialog(
          context: context,
          builder: (context) => PermissionDialog(
              isDenied: true,
              onPressed: () async {
                Navigator.pop(context);
                await Geolocator.requestPermission();
                checkPermission(context, callback);
              }));
    } else if (permission == LocationPermission.deniedForever) {
      showDialog(
          context: context,
          builder: (context) => PermissionDialog(
              isDenied: false,
              onPressed: () async {
                Navigator.pop(context);
                await Geolocator.openAppSettings();
                checkPermission(context, callback);
              }));
    } else {
      callback();
    }
  }
}
