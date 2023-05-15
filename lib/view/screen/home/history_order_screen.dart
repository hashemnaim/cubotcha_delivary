import 'package:delivery_boy/controller/controller_order.dart';
import 'package:delivery_boy/values/dimensions.dart';
import 'package:delivery_boy/values/export.dart';
import 'package:delivery_boy/values/styles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../server/server_order.dart';
import '../order/order_details_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  OrderController orderController = Get.find();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  int indexDate = 0;
@override
  void initState() {
  indexDate = 0;
                       ServerOrder.instance
                          .getOrderFinish(DateTime.now().toString());
                         super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage("assets/images/background.png"),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      indexDate = 2;

                      await ServerOrder.instance.getOrderFinish("");
                      setState(() {});
                    },
                    child: Container(
                        height: 38.h,
                        width: 100.w,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CustomText(
                            text: "الكل".tr,
                            color: indexDate == 2
                                ? AppColors.white
                                : AppColors.blackLight,
                            fontSize: 17,
                          ),
                        )),
                        decoration: BoxDecoration(
                            color: indexDate == 2
                                ? AppColors.primary
                                : AppColors.gray,
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(width: 15.w),
                  InkWell(
                    onTap: () async {
                      indexDate = 1;

                      await ServerOrder.instance.getOrderFinish(DateTime.now()
                          .subtract(Duration(days: 1))
                          .toString());
                      setState(() {});
                    },
                    child: Container(
                        height: 38.h,
                        width: 100.w,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CustomText(
                            text: "امس".tr,
                            color: indexDate == 1
                                ? AppColors.white
                                : AppColors.blackLight,
                            fontSize: 17,
                          ),
                        )),
                        decoration: BoxDecoration(
                            color: indexDate == 1
                                ? AppColors.primary
                                : AppColors.gray,
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(width: 15.w),
                  InkWell(
                    onTap: () async {
                      indexDate = 0;
                      await ServerOrder.instance
                          .getOrderFinish(DateTime.now().toString());
                      // orderController.finshOrderModel.value.orderId!
                      setState(() {});
                    },
                    child: Container(
                      height: 38.h,
                      width: 100.w,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Center(
                          child: CustomText(
                            text: "اليوم",
                            color: indexDate == 0
                                ? AppColors.white
                                : AppColors.blackLight,
                            fontSize: 18,
                          ),
                        ),
                      )),
                      decoration: BoxDecoration(
                          color: indexDate == 0
                              ? AppColors.primary
                              : AppColors.gray,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: orderController.finshOrderModel.value.orderId!.isNotEmpty
                  ? RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: () async {
                        indexDate = 0;
                        await ServerOrder.instance
                            .getOrderFinish(DateTime.now().toString());
                        setState(() {});
                      },
                      child: Obx(
                        () => ListView.builder(
                            itemCount: orderController
                                .finshOrderModel.value.orderId!.length,
                            padding:
                                EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            itemBuilder: (context, index) {
                              orderController.finshOrderModel.value.orderId!
                                  .sort((a, b) => b.id!.compareTo(a.id!));
                              return InkWell(
                                onTap: () async {
                                  await ServerOrder.instance.getOrderId(
                                    orderController.finshOrderModel.value
                                        .orderId![index].id!,
                                  );
                                  Get.to(() => OrderDetailsScreen(
                                        index: index,
                                        user: orderController.finshOrderModel
                                            .value.orderId![index].user!,
                                      ));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.PADDING_SIZE_SMALL),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .shadowColor
                                              .withOpacity(.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(0, 1))
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '# ${orderController.finshOrderModel.value.orderId![index].id}',
                                              style: rubikMedium.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_EXTRA_LARGE,
                                                  color: AppColors.bluColor),
                                            ),
                                            Text(
                                              '# ${orderController.finshOrderModel.value.orderId![index].code}',
                                              style: rubikMedium.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_EXTRA_LARGE,
                                                  color: AppColors.bluColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              Container(
                                                  height: 10,
                                                  width: 10,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          AppColors.primary)),
                                              Text(
                                                '  ${orderController.finshOrderModel.value.orderId![index].updatedAt!.substring(0, 10)}',
                                                style: rubikRegular.copyWith(
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_SMALL,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .color),
                                              ),
                                            ]),
                                            Text(
                                                (double.parse(orderController
                                                            .finshOrderModel
                                                            .value
                                                            .orderId![index]
                                                            .totalPrice!))
                                                        .toStringAsFixed(2) +
                                                    " جنيه",
                                                style: rubikRegular.copyWith(
                                                    fontSize: 20,
                                                    color: AppColors.primary)),
                                          ],
                                        ),
                                      ]),
                                ),
                              );
                            }),
                      ))
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: CustomText(
                          text: 'لا يوجد طلبات',
                          color: AppColors.blackDark,
                          fontSize: 30,
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                          text: "الاجمالي",
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                      if (orderController
                          .finshOrderModel.value.orderId!.isEmpty)
                        CustomText(text: "0", fontSize: 24.sp)
                      else
                        CustomText(
                            text: orderController.finshOrderModel.value.orderId!
                                .map((e) => e.totalPrice)
                                .toList()
                                .reduce((value, element) =>
                                    ((double.parse(value!) +
                                            double.parse(element!))
                                        .toStringAsFixed(0)))!,
                            color: AppColors.blackLight,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                          text: "الطلبات",
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                      if (orderController.finshOrderModel.value.orderId!.isEmpty)
                        CustomText(text: "0", fontSize: 24.sp)
                      else
                        CustomText(
                            text: (double.parse(orderController
                                        .finshOrderModel.value.orderId!
                                        .map((e) => e.totalPrice)
                                        .toList()
                                        .reduce((value, element) =>
                                            ((double.parse(value!) + double.parse(element!)))
                                                .toString())!) -
                                    double.parse(orderController
                                        .finshOrderModel.value.orderId!
                                        .map((e) => e.deliveryCost)
                                        .toList()
                                        .reduce((value, element) =>
                                            ((double.parse(value!) + double.parse(element!))).toString())
                                        .toString()))
                                .toStringAsFixed(0),
                            color: AppColors.blackLight,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                          text: "التوصيل",
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                      orderController.finshOrderModel.value.orderId!.isEmpty
                          ? CustomText(text: "0", fontSize: 24.sp)
                          : CustomText(
                              text: orderController
                                  .finshOrderModel.value.orderId!
                                  .map((e) => e.deliveryCost)
                                  .toList()
                                  .reduce((value, element) =>
                                      ((double.parse(value!) +
                                              double.parse(element!))
                                          .toStringAsFixed(0)))!,
                              color: AppColors.blackLight,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                          text: "عدد الطلبات",
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                      orderController.finshOrderModel.value.orderId!.isEmpty
                          ? CustomText(text: "0", fontSize: 24.sp)
                          : CustomText(
                              text: orderController
                                  .finshOrderModel.value.orderId!.length
                                  .toString(),
                              color: AppColors.blackLight,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }));
  }
}
