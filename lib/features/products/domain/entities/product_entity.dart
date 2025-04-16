class ProductEntity {
  final String id;
  final String name;
  double quantity;
  double buyingPrice;
  double sellingPrice;
  final double? dollarPrice;
  final int? packageQuantity;
  final double? packagePrice;

  ProductEntity({
    this.dollarPrice,
    this.packageQuantity,
    required this.id,
    required this.name,
    required this.quantity,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.packagePrice,
  });
}
