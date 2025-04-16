import 'package:market/features/sales/domain/entities/sale_entity.dart';

class InvoiceModel extends InvoiceEntity {
  InvoiceModel(
      {required super.discount,
    super.id,
    required super.dateAndTime,
    required super.userName,
    required super.price,
    super.customerId,
    super.customerName,
    super.sales,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      discount:json['discount']??0,
        dateAndTime: json['dateAndTime'],
        id: json['id'],
        price: json['price']??0,
        userName: json['userName'],
        customerId: json['customerId'],
        customerName: json['customerName']);
  }

  Map<String, dynamic> toJson() {
    return {
      'dateAndTime': dateAndTime,
      'price': price,
      'userName': userName,
      'customerName': customerName,
      'customerId': customerId,
      'discount':discount,
    };
  }
}

class SaleModel extends SaleEntity {
  SaleModel({
    required super.productId,
    required super.quantity,
    required super.price,
    required super.productName,
    super.id,
    required super.piecePrice,
    super.saleInvoice,
    required super.userName,
    super.customerId,
    super.customerName,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
        productId: json['productId'],
        saleInvoice: json['saleInvoice'],
        quantity: double.parse(json['quantity'].toString()),
        price: json['price'],
        productName: json['productName'],
        id: json['id'],
        userName: json['userName'],
        customerName: json['customerName'],
        customerId: json['customerId'],
      piecePrice: json['price']/json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'productId': productId,
      'saleInvoice': saleInvoice,
      'quantity': quantity,
      'price': price,
      'productName': productName,
      'userName': userName,
      'customerName': customerName,
      'customerId': customerId,
    };
  }
}
