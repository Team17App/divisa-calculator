import 'dart:convert';

class ProductModel {
  final int id;
  String name;
  double price;
  int type;
  int quantity;
  dynamic category;
  dynamic attributes;

  ProductModel({
    this.id = 0,
    this.name = '',
    this.price = 0.0,
    this.type = 0,
    this.quantity = 1,
    this.category,
    this.attributes,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    double? price,
    int? type,
    int? quantity,
    dynamic category,
    dynamic attributes,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        type: type ?? this.type,
        quantity: quantity ?? this.quantity,
        category: category ?? this.category,
        attributes: attributes ?? this.attributes,
      );

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"]?.toDouble(),
        type: json["type"],
        quantity: json["quantity"],
        category: json["category"],
        attributes: json["attributes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "type": type,
        "quantity": quantity,
        "category": category,
        "attributes": attributes,
      };

  double get subTotal {
    final amount = price * quantity;
    return amount;
  }

// DOLLAR TO COP
  double refFromDollar(double ref) {
    final amount = price * quantity;
    return amount * ref;
  }

  double refToDollar(double ref) {
    final amount = price * quantity;

    if (ref != 0) return amount / ref;
    return 0.0;
  }
}
