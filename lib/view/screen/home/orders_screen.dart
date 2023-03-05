import 'package:delivery_boy/controller/controller_order.dart';
import 'package:delivery_boy/server/server_order.dart';
import 'package:delivery_boy/values/export.dart';
import 'package:delivery_boy/view/screen/home/widget/order_widget.dart';
import 'package:get/get.dart';

import '../../../model/order_modal.dart';
import '../../main_screen.dart';

class OrdersScreen extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  OrderController orderController = Get.find();
  final List<OrderDetails>? processing;
  OrdersScreen({required this.processing});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            actions: [
              IconButton(
                icon: Icon(Icons.refresh,
                    color: Theme.of(context).textTheme.bodyText1!.color),
                onPressed: () async {
                  await ServerOrder.instance.getOrders();
                },
              ),
            ],
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).textTheme.bodyText1!.color),
              onPressed: () async {
                Get.off(() => MainScreen());
              },
            ),
            centerTitle: true,
            title: CustomPngImage(
              "im3",
              height: 60,
              width: 100,
            )),
        body: Obx(() => Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage("assets/images/background.png"),
                      fit: BoxFit.fill)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10),
                    Expanded(
                      child: RefreshIndicator(
                        key: _refreshIndicatorKey,
                        child: orderController.newOrderModel.value.orderId!
                                    .processing!.length !=
                                0
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: processing!.length,
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                itemBuilder: (context, index) {
                                  return OrderWidget(
                                    orderModel: processing!,
                                    index: index,
                                  );
                                })
                            : Center(
                                child: CustomText(
                                  text: 'لا يوجد طلبات',
                                  fontSize: 20,
                                ),
                              ),
                        displacement: 0,
                        color: AppColors.primary,
                        backgroundColor: AppColors.primary,
                        onRefresh: () {
                          return ServerOrder.instance.getOrders();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
