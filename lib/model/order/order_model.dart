class OrderModel {
  String? from;
  String? date;
  String? user;
  String? payment;
  List<Shipment>? shipment;

  OrderModel({this.from, this.date, this.user, this.payment, this.shipment});

  OrderModel.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    date = json['date'];
    user = json['user'];
    payment = json['payment'];
    if (json['shipment'] != null) {
      shipment = <Shipment>[];
      json['shipment'].forEach((v) {
        shipment!.add(new Shipment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['date'] = this.date;
    data['user'] = this.user;
    data['payment'] = this.payment;
    if (this.shipment != null) {
      data['shipment'] = this.shipment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shipment {
  String? to;
  int? cost;
  List<Products>? products;

  Shipment({this.to, this.cost, this.products});

  Shipment.fromJson(Map<String, dynamic> json) {
    to = json['to'];
    cost = json['cost'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to'] = this.to;
    data['cost'] = this.cost;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? product;
  String? type;
  String? size;
  int? count;

  Products({this.product, this.type, this.size, this.count});

  Products.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    type = json['type'];
    size = json['size'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['type'] = this.type;
    data['size'] = this.size;
    data['count'] = this.count;
    return data;
  }
}