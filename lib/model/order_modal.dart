class OrderModel {
  int? code;
  bool? status;
  String? message;
  OrderId? orderId;

  OrderModel({this.code, this.status, this.message, this.orderId});

  OrderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    orderId = json['order_id'] != null
        ? new OrderId.fromJson(json['order_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.orderId != null) {
      data['order_id'] = this.orderId!.toJson();
    }
    return data;
  }
}

class OrderId {
  List<Processing>? processing;

  OrderId({this.processing});

  OrderId.fromJson(Map<String, dynamic> json) {
    if (json['processing'] != null) {
      processing = <Processing>[];
      json['processing'].forEach((v) {
        processing!.add(new Processing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.processing != null) {
      data['processing'] = this.processing!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Processing {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? userId;
  String? totalPrice;
  String? status;
  String? statusCode;
  String? deliveryCost;
  String? tax;
  String? time;
  String? day;

  String? mobile;
  String? discount;
  String? cartonId;
  String? driverId;
  String? code;
  String? cash;
  String? addressId;
  String? sumPoints;
  User? user;
  ShippingAddress? shippingAddress;

  Processing(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.totalPrice,
      this.status,
      this.statusCode,
      this.deliveryCost,
      this.tax,
      this.time,
      this.day,
      this.mobile,
      this.discount,
      this.cartonId,
      this.driverId,
      this.code,
      this.cash,
      this.addressId,
      this.sumPoints,
      this.user,
      this.shippingAddress});

  Processing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    totalPrice = json['total_price'];
    status = json['status'];
    statusCode = json['status_code'];
    deliveryCost = json['delivery_cost'];
    tax = json['tax'];
    time = json['time'];
    day = json['day'];

    mobile = json['mobile'];
    discount = json['discount'];
    cartonId = json['carton_id'];
    driverId = json['driver_id'];
    code = json['code'];
    cash = json['cash'];
    addressId = json['address_id'];
    sumPoints = json['sum_points'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    shippingAddress = json['shipping_address'] != null
        ? new ShippingAddress.fromJson(json['shipping_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['delivery_cost'] = this.deliveryCost;
    data['tax'] = this.tax;
    data['time'] = this.time;
    data['day'] = this.day;

    data['mobile'] = this.mobile;
    data['discount'] = this.discount;
    data['carton_id'] = this.cartonId;
    data['driver_id'] = this.driverId;
    data['code'] = this.code;
    data['cash'] = this.cash;
    data['address_id'] = this.addressId;
    data['sum_points'] = this.sumPoints;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? mobile;

  String? type;

  String? createdAt;
  String? updatedAt;
  String? membership;
  String? mobileVerifyCode;
  String? status;
  String? upgradeStatus;
  String? points;
  String? balance;
  String? address;
  String? fcmToken;

  User(
      {this.id,
      this.name,
      this.mobile,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.membership,
      this.mobileVerifyCode,
      this.status,
      this.upgradeStatus,
      this.points,
      this.balance,
      this.address,
      this.fcmToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];

    type = json['type'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    membership = json['membership'];
    mobileVerifyCode = json['mobile_verify_code'];
    status = json['status'];
    upgradeStatus = json['upgrade_status'];
    points = json['points'];
    balance = json['balance'];
    address = json['address'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;

    data['type'] = this.type;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['membership'] = this.membership;
    data['mobile_verify_code'] = this.mobileVerifyCode;
    data['status'] = this.status;
    data['upgrade_status'] = this.upgradeStatus;
    data['points'] = this.points;
    data['balance'] = this.balance;
    data['address'] = this.address;
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}

class ShippingAddress {
  int? id;
  String? phone;
  String? street;
  String? lat;
  String? lng;
  String? createdAt;
  String? updatedAt;
  String? userId;
  String? cityId;
  String? areaId;
  String? isDefault;

  ShippingAddress(
      {this.id,
      this.phone,
      this.street,
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.cityId,
      this.areaId,
      this.isDefault});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    street = json['street'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['street'] = this.street;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['city_id'] = this.cityId;
    data['area_id'] = this.areaId;
    data['is_default'] = this.isDefault;
    return data;
  }
}
