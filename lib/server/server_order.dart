import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:delivery_boy/controller/controller_order.dart';
import 'package:delivery_boy/model/HistoryOrderModel.dart';
import 'package:delivery_boy/model/detailsProduct_model.dart';
import 'package:delivery_boy/model/order_modal.dart';
import 'package:delivery_boy/values/export.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

class ServerOrder {
  ServerOrder._();
  static ServerOrder instance = ServerOrder._();
  Dio? dio;
  AppController appController = getx.Get.find();
  OrderController orderController = getx.Get.find();

  initApi() {
    if (dio == null) {
      dio = Dio();
      return dio;
    } else {
      return dio;
    }
  }
//////////////////////////////////////////////////////////////////////////

  getOrders() async {
    initApi();
    try {
      BotToast.showLoading();
      Response response = await dio!.post(url + 'driver/my_orders',
          options: Options(headers: {
            'Authorization': 'Bearer ${SHelper.sHelper.getToken()}'
          }));

      BotToast.closeAllLoading();

      if (response.data['code'] == 200) {
        orderController.newOrderModel.value =
            OrderModel.fromJson(response.data);
      }
      return orderController.newOrderModel.value;
    } catch (e) {
      BotToast.closeAllLoading();

      return null;
    }
  }

  ////////////////////
  getOrderId(int idOrder) async {
    initApi();
    BotToast.showLoading();
    try {
      Response response = await dio!.post(url + 'order/orders',
          data: {"order_id": idOrder},
          options: Options(headers: {
            'Authorization': 'Bearer ${SHelper.sHelper.getToken()}'
          }));

      BotToast.closeAllLoading();

      if (response.data['code'] == "200") {
        orderController.detailsProdact.value =
            DetailsProductModel.fromJson(response.data);
      }
    } catch (e) {
      BotToast.closeAllLoading();

      return null;
    }
  }
  //////////////////////////////////////////////////////////////////////////

  changeStatus(int? orderId, String fcmToken) async {
    initApi();
    BotToast.showLoading();

    try {
      Response response = await dio!.post(url + 'driver/change-status',
          data: {
            "order_id": orderId,
          },
          options: Options(headers: {
            'Authorization': 'Bearer ${SHelper.sHelper.getToken()}'
          }));
      BotToast.closeAllLoading();

      if (response.data['code'] == 200) {
        getOrders();
        getOrderFinish("");
      }
    } catch (e) {
      BotToast.closeAllLoading();

      return null;
    }
  }
  //////////////////////////////////////////////////////////////////////////

  getOrderFinish(String date) async {
    initApi();

    try {
      BotToast.showLoading();
      Response response = await dio!.post(url + 'driver/finish_order',
          options: Options(headers: {
            'Authorization': 'Bearer ${SHelper.sHelper.getToken()}'
          }));
      BotToast.closeAllLoading();
      if (response.data['code'] == 200) {
        orderController.finshOrderModel.value =
            FinishOrderModel.fromJson(response.data);

        date != ""
            ? orderController.finshOrderModel.value.orderId = orderController
                .finshOrderModel.value.orderId!
                .where((element) =>
                    element.updatedAt!.substring(0, 10) ==
                    date.substring(0, 10))
                .toList()
            : orderController.finshOrderModel.value;
      }
    } catch (e) {
      BotToast.closeAllLoading();
      return null;
    }
  }
}
