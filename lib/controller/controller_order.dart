import 'package:delivery_boy/model/HistoryOrderModel.dart';
import 'package:delivery_boy/model/detailsProduct_model.dart';
import 'package:delivery_boy/model/order_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../helper/location_helper.dart';
import '../print/invoice_settings.controller.dart';

class OrderController extends GetxController {
  Rx<OrderModel> newOrderModel = OrderModel().obs;
  Rx<FinishOrderModel> finshOrderModel = FinishOrderModel().obs;
  Rx<DetailsProductModel> detailsProdact = DetailsProductModel().obs;
  InvoiceSettingsController inoviceControl =
      Get.find<InvoiceSettingsController>();
  int lenght = 0;

  // else {
  //   String sp = " ";
  //   for (int i = 0 + getSizeCh(s); i < (length - s.length); i++) {
  //     sp = sp + " ";
  //   }
  //   return s + sp;
  // }

  int getSizeCh(String s) {
    lenght = s.contains("س") || s.contains("ض") ? 2 : 0;
    return lenght;
  }

  String getSpaceint(
    String s,
  ) {
    if (s.length > 3) {
      return s.substring(0, 4);
    } else {
      return s + "0";
    }
  }

  @override
  void onInit() async {
    await LocationHelper().getCurrentLocation();

    super.onInit();
  }
}
