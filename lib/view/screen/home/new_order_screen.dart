import 'package:delivery_boy/controller/controller_order.dart';
import 'package:delivery_boy/server/server_order.dart';
import 'package:delivery_boy/values/export.dart';
import 'package:get/get.dart';
import '../../../helper/method_helpar.dart';
import 'orders_screen.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  OrderController orderController = Get.find();
  List<String> times = ["13-11", "14-12", "17-15", "20-18", "21-19", "22-20", "23-22"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("assets/images/background.png"),
              fit: BoxFit.fill)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Expanded(
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: times.length,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemBuilder: (context, index) {
                      // Comparator<Processing> sortById =
                      //     (a, b) => b.time!.compareTo(a.time!);

                      // orderController
                      //     .newOrderModel.value.orderId!.processing!
                      //     .sort(sortById);
                      // int list = ;

                      return InkWell(
                          onTap: () {
                            Get.to(() => OrdersScreen(
                                processing: orderController
                                    .newOrderModel.value.orderId!.processing!
                                    .where((element) =>
                                        element.time == times[index])
                                    .toList()));
                          },
                          child: Obx(
                            () => Card(
                              elevation: 2,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: orderController.newOrderModel.value
                                          .orderId!.processing!
                                          .where((element) =>
                                              element.time == times[index])
                                          .toList()
                                          .length ==
                                      0
                                  ? Colors.grey[300]
                                  : Colors.green[200],
                              margin: EdgeInsets.all(4),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                            text: "الفترة",
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.w600),
                                        CustomText(
                                            text: "",
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.w600),
                                        CustomText(
                                            text: "الطلبات",
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.w600),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                            text: getPeriod(times[index]),
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.w600),
                                        CustomText(
                                            text: '',
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.w600),
                                        CustomText(
                                            text:
                                                '${orderController.newOrderModel.value.orderId!.processing!.where((element) => element.time == times[index]).toList().length}   ',
                                            fontSize: 25.sp,
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.w600),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                    }),
                displacement: 0,
                color: AppColors.primary,
                backgroundColor: AppColors.primary,
                onRefresh: () async {
                  return await ServerOrder.instance.getOrders();
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
