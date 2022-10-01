import 'dart:developer';

import 'package:delivery_boy/model/order_modal.dart';
import 'package:delivery_boy/server/server_order.dart';
import 'package:delivery_boy/services/luncher.dart';
import 'package:delivery_boy/values/dimensions.dart';
import 'package:delivery_boy/values/export.dart';
import 'package:delivery_boy/view/screen/order/order_details_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderWidget extends StatelessWidget {
  final List<Processing>? orderModel;
  final int index;
  OrderWidget({this.orderModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: AppColors.gray.withOpacity(.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1))
            ],
            color: AppColors.gray.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: '#${orderModel![index].id.toString()}',
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w600,
                ),
                InkWell(
                  onTap: () {
                    launch('tel:${orderModel![index].mobile ?? ""}');
                  },
                  child: CustomText(
                    text: '${orderModel![index].mobile ?? ''}',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.person,
                  color: AppColors.primary,
                ),
                SizedBox(width: 8),
                CustomText(
                  text: '${orderModel![index].user!.name ?? ''}',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                ),
                SizedBox(width: 8),
                Expanded(
                    child: CustomText(
                  text: orderModel![index].shippingAddress!.street,
                )),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: AppColors.white),
                  child: IconButton(
                      icon: Icon(Icons.phone, color: AppColors.primary),
                      onPressed: () {
                        launch('tel:${orderModel![index].mobile ?? ""}');
                      }),
                ),
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: AppColors.white),
                  child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: AppColors.primary,
                      ),
                      onPressed: () async {
                        await ServerOrder.instance
                            .getOrderId(orderModel![index].id!);
                        Get.to(() => OrderDetailsScreen(
                              index: index,
                              user: orderModel![index].user,
                            ));
                      }),
                ),
                Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: AppColors.white),
                    child: IconButton(
                        icon: Icon(Icons.location_on, color: AppColors.primary),
                        onPressed: () async {
                          var position = await Geolocator.getCurrentPosition();

                          MapUtils.openMap(
                              double.parse(
                                  orderModel![index].shippingAddress!.lat!),
                              double.parse(
                                  orderModel![index].shippingAddress!.lng!),
                              position.latitude,
                              position.longitude);
                        }))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(
      double destinationLatitude,
      double destinationLongitude,
      double userLatitude,
      double userLongitude) async {
    String googleUrl =
        'https://www.google.com/maps/dir/?api=1&origin=$userLatitude,$userLongitude'
        '&destination=$destinationLatitude,$destinationLongitude&mode=d';
    Launcher.launcher.launchURL(googleUrl);
    // if (await canLaunch(googleUrl)) {
    //   await launch(googleUrl);
    // } else {
    //   throw 'Could not open the map.';
    // }
  }
}
