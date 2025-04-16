class PurchaseEntity {
  final int? id;
  final String productName;
  final String productId;
  final String userName;
  final String dateAndTime;
  final double quantity;
  final double buyingPrice;
  final double sellingPrice;
  final double? dollarPrice;
  final double? packagePrice;
  final int? package;

  PurchaseEntity({
    required this.userName,
    required this.dateAndTime,
    this.id,
    required this.productId,
    required this.quantity,
    required this.sellingPrice,
    required this.buyingPrice,
    required this.productName,
    this.dollarPrice,
    this.packagePrice,
    this.package,
  });
}
