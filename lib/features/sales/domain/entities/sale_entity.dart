import 'package:market/features/sales/data/models/sale_model.dart';

class InvoiceEntity {
  final int? id;
  final String dateAndTime;
  final double price;
  final String userName;
  final String? customerName;
  final int? customerId;
   List<SaleModel>? sales;
   final double discount;

  InvoiceEntity({required this.discount,
    this.sales,
    required this.userName,
    this.customerName,
    this.customerId,
    this.id,
    required this.dateAndTime,
    required this.price,
  });
}

class SaleEntity {
  final int? id;
  final String productName;
  final String productId;
   double quantity;
   double price;
   final double piecePrice;
  final String userName;
  final String? customerName;
  final int? customerId;
  int? saleInvoice;

  SaleEntity({
    required this.userName,
    this.customerName,
    this.customerId,
    required this.piecePrice,
    this.id,
    this.saleInvoice,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.productName,
  });
}
