class Order {
  String from;
  String date;
  String user;
  String payment;
  List<Shipment> shipment;

  Order({
    required this.from,
    required this.date,
    required this.user,
    required this.payment,
    required this.shipment,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      from: json['from'],
      date: json['date'],
      user: json['user'],
      payment: json['payment'],
      shipment: List<Shipment>.from(
        json['shipment'].map((shipment) => Shipment.fromJson(shipment)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'date': date,
      'user': user,
      'payment': payment,
      'shipment': shipment.map((shipment) => shipment.toJson()).toList(),
    };
  }
}

class Shipment {
  String to;
  int cost;
  List<Product> products;

  Shipment({
    required this.to,
    required this.cost,
    required this.products,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      to: json['to'],
      cost: json['cost'],
      products: List<Product>.from(
        json['products'].map((product) => Product.fromJson(product)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'to': to,
      'cost': cost,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class Product {
  String product;
  String type;
  String size;
  int count;

  Product({
    required this.product,
    required this.type,
    required this.size,
    required this.count,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      product: json['product'],
      type: json['type'],
      size: json['size'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'type': type,
      'size': size,
      'count': count,
    };
  }
}
