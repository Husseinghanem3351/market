import 'package:market/features/purchase/domain/entities/Purchase_entity.dart';

class PurchaseModel extends PurchaseEntity {
  PurchaseModel({
    required super.productId,
    required super.quantity,
    required super.buyingPrice,
    required super.sellingPrice,
    required super.productName,
    super.id,
    required super.userName,
    required super.dateAndTime,
    super.dollarPrice,
    super.package,
    super.packagePrice,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      id: json['id'],
      productName: json['productName'],
      quantity: json['quantity'],
      sellingPrice: json['sellingPrice'],
      buyingPrice: json['buyingPrice'],
      userName: json['userName'],
      dateAndTime: json['dateAndTime'],
      productId: json['productId']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId':productId,
      'productName': productName,
      'quantity': quantity,
      'buyingPrice': buyingPrice,
      'sellingPrice': sellingPrice,
      'userName': userName,
      'dateAndTime': dateAndTime,
    };
  }
}
