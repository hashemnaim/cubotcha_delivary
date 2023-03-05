import 'order_modal.dart';

class FinishOrderModel {
  int? code;
  bool? status;
  String? message;
  List<OrderDetails>? orderId;
  FinishOrderModel({this.code, this.status, this.message, this.orderId});

  FinishOrderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['order_id'] != null) {
      orderId = <OrderDetails>[];
      json['order_id'].forEach((v) {
        orderId!.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.orderId != null) {
      data['order_id'] = this.orderId!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
