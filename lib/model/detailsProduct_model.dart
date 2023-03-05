class DetailsProductModel {
  String? code;
  bool? status;
  Orders? orders;
  DetailsProductModel({this.code, this.status, this.orders});

  DetailsProductModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    orders =
        json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.orders != null) {
      data['orders'] = this.orders!.toJson();
    }
    return data;
  }
}

class Orders {
  int? orderId;
  String? code;
  String? date;
  String? time;
  String? totalPrice;
  String? deliveryCost;
  String? discount_price;
  String? tax;
  String? status;
  String? statusCode;
  List<Products>? products;
  List<Cartons>? cartons;
  String? cash;
  Address? address;

  Orders(
      {this.orderId,
      this.code,
      this.date,
      this.time,
      this.totalPrice,
      this.deliveryCost,
      this.tax,
      this.status,
      this.statusCode,
      this.discount_price,
      this.products,
      this.cartons,
      this.cash,
      this.address});

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    code = json['code'];
    date = json['date'];
    time = json['time'];
    totalPrice = json['total_price'].toString();
    deliveryCost = json['delivery_cost'];
    tax = json['tax'];
    status = json['status'];
    discount_price = json['discount_price'].toString();
    statusCode = json['status_code'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['cartons'] != null) {
      cartons = <Cartons>[];
      json['cartons'].forEach((v) {
        cartons!.add(new Cartons.fromJson(v));
      });
    }
    cash = json['cash'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['code'] = this.code;
    data['date'] = this.date;
    data['time'] = this.time;
    data['total_price'] = this.totalPrice;
    data['delivery_cost'] = this.deliveryCost;
    data['tax'] = this.tax;
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.cartons != null) {
      data['cartons'] = this.cartons!.map((v) => v.toJson()).toList();
    }
    data['cash'] = this.cash;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Products {
  String? id;
  String? name;
  String? price;
  String? categoryId;
  String? unit;
  String? maxQty;
  String? points;
  String? stock;
  String? quantity;
  String? image;

  Products(
      {this.id,
      this.name,
      this.price,
      this.categoryId,
      this.unit,
      this.maxQty,
      this.points,
      this.stock,
      this.quantity,
      this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    price = double.parse(json['price'] == "" ? "0" : json['price'])
        .toStringAsFixed(1);
    categoryId = json['category_id'];
    unit = json['unit'];
    maxQty = json['max_qty'];
    points = json['points'];
    stock = json['stock'];
    quantity = double.parse(json['quantity'] == "" ? "0" : json['quantity'])
        .toStringAsFixed(1);
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['category_id'] = this.categoryId;
    data['unit'] = this.unit;
    data['max_qty'] = this.maxQty;
    data['points'] = this.points;
    data['stock'] = this.stock;
    data['quantity'] = double.parse(this.quantity!).toStringAsFixed(1);
    data['image'] = this.image;
    return data;
  }
}

class Cartons {
  int? id;
  String? orderId;
  String? cartonId;
  String? cartonName;
  String? cartonPrice;
  String? quantity;
  String? totalPrice;
  String? image;

  Cartons(
      {this.id,
      this.orderId,
      this.cartonId,
      this.cartonName,
      this.cartonPrice,
      this.quantity,
      this.totalPrice,
      this.image});

  Cartons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    cartonId = json['carton_id'];
    cartonName = json['carton_name'];
    cartonPrice = double.parse(json['carton_price']).toStringAsFixed(1);
    quantity = double.parse(json['quantity']).toStringAsFixed(1);

    totalPrice = json['total_price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['carton_id'] = this.cartonId;
    data['carton_name'] = this.cartonName;
    data['carton_price'] = this.cartonPrice;
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
    data['image'] = this.image;
    return data;
  }
}

class Address {
  int? id;
  String? phone;
  String? street;
  String? building;
  String? apartment;
  String? lat;
  String? lng;
  String? city;
  String? area;

  Address(
      {this.id,
      this.phone,
      this.street,
      this.building,
      this.apartment,
      this.lat,
      this.lng,
      this.city,
      this.area});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    street = json['street'];
    building = json['building'];
    apartment = json['apartment'];
    lat = json['lat'];
    lng = json['lng'];
    city = json['city'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['street'] = this.street;
    data['building'] = this.building;
    data['apartment'] = this.apartment;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['city'] = this.city;
    data['area'] = this.area;
    return data;
  }
}
