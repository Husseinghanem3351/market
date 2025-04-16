import 'package:market/features/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.quantity,
    required super.buyingPrice,
    required super.sellingPrice,
    required super.dollarPrice,
    required super.packageQuantity,
    required super.packagePrice,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      quantity: double.parse(json['quantity'].toString()),
      id: json['id'],
      name: json['name'],
      buyingPrice: json['buyingPrice'],
      sellingPrice: json['sellingPrice'],
      dollarPrice: json['dollarPrice'],
      packageQuantity: json['packageQuantity'],
      packagePrice: json['packagePrice']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'quantity': quantity,
      'name': name,
      'sellingPrice': sellingPrice,
      'buyingPrice': buyingPrice,
      'packageQuantity': packageQuantity,
      'dollarPrice': dollarPrice,
      'packagePrice': packagePrice,
    };
  }
}
