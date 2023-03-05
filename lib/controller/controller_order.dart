import 'package:delivery_boy/model/HistoryOrderModel.dart';
import 'package:delivery_boy/model/detailsProduct_model.dart';
import 'package:delivery_boy/model/order_modal.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:image/image.dart' as im;
import 'package:sunmi_printer_plus/sunmi_style.dart';

import '../helper/location_helper.dart';
import '../print/invoice_settings.controller.dart';

class OrderController extends GetxController {
  Rx<OrderModel> newOrderModel = OrderModel().obs;
  Rx<FinishOrderModel> finshOrderModel = FinishOrderModel().obs;
  Rx<DetailsProductModel> detailsProdact = DetailsProductModel().obs;
  InvoiceSettingsController inoviceControl =
      Get.find<InvoiceSettingsController>();
  int lenght = 0;
  invoiceBuilder(Orders orderDetails) async {
    final CapabilityProfile profile = await CapabilityProfile.load();

    final generator = Generator(PaperSize.mm58, profile);

    await inoviceControl.invoiceBuilder(orderDetails);

    List<int> bytes = [];

    im.Image? image;
    image = im.decodeImage(inoviceControl.invoiceAsImage);

    bytes += generator.image(image!);

    bytes += generator.feed(2);
    bytes += generator.cut();
    await printSunmiPrinter(bytes);
  }

  Future<void> printSunmiPrinter(List<int> orderBytes) async {
    final bool? result = await SunmiPrinter.bindingPrinter();

    if (result!) {
      await SunmiPrinter.initPrinter();
      await SunmiPrinter.startTransactionPrint(true);
      await SunmiPrinter.printRawData(Uint8List.fromList(orderBytes));
      await SunmiPrinter.exitTransactionPrint(true);
    }
  }

  Future<void> printSunmi(Orders order) async {
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    // await SunmiPrinter.setCustomFontSize(13);

    await SunmiPrinter.printText('كابوتشا',
        style: SunmiStyle(
            fontSize: SunmiFontSize.XL,
            bold: true,
            align: SunmiPrintAlign.CENTER));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText("رقم الفاتورة : #${order.code}",
        style: SunmiStyle(
            fontSize: SunmiFontSize.LG,
            bold: true,
            align: SunmiPrintAlign.RIGHT));

    await SunmiPrinter.printText("اسم المستخدم : هاشم",
        style: SunmiStyle(
            fontSize: SunmiFontSize.MD,
            bold: true,
            align: SunmiPrintAlign.RIGHT));
    await SunmiPrinter.printText(
        "موعد الطللب : ${order.date}" " / " "${order.time}",
        style: SunmiStyle(
            fontSize: SunmiFontSize.MD,
            bold: true,
            align: SunmiPrintAlign.RIGHT));
    await SunmiPrinter.printText("الدفع : كاش",
        style: SunmiStyle(
            fontSize: SunmiFontSize.MD,
            bold: true,
            align: SunmiPrintAlign.RIGHT));
    await SunmiPrinter.line();

    await SunmiPrinter.printText(
        "الكمية" +
            "\t\t\t\t" +
            "السعر" +
            "\t\t\t\t\t" +
            "الاجمالي" +
            "\t\t\t\t\t" +
            "الصنف",
        style: SunmiStyle(
            fontSize: SunmiFontSize.MD,
            bold: true,
            align: SunmiPrintAlign.RIGHT));
    await SunmiPrinter.line();
    for (Products product in order.products!) {
      await SunmiPrinter.printText(
          getSpaceint(
                product.quantity!,
              ) +
              "\t\t\t\t\t\t" +
              getSpaceint(product.price!) +
              "\t\t\t\t\t\t" +
              getSpaceint((double.parse(product.price!) *
                      double.parse(product.quantity!))
                  .toStringAsFixed(1)) +
              "\t\t\t\t\t\t" +
              getSpace(product.name!),
          // getSpace(product.name!, 13)

          style: SunmiStyle(
              fontSize: SunmiFontSize.MD,
              bold: true,
              align: SunmiPrintAlign.RIGHT));
    }

    await SunmiPrinter.lineWrap(3);
    await SunmiPrinter.exitTransactionPrint(true);
  }

  String getSpace(String name) {
    if (name.length > 10) {
      return name.substring(0, 10);
    } else {
      return name;
    }
  }

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
