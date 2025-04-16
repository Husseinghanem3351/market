
class ProductIdModel {
  final int id;
  final String productId;
  final int productIdNumber;

  ProductIdModel({
    required this.id,
    required this.productId,
    required this.productIdNumber,
  });

  factory ProductIdModel.fromJson(Map<String, dynamic> json) {
    return ProductIdModel(
      id: json['id'],
      productId: json['productId'],
      productIdNumber: json['productIdNumber'],
    );
  }
}
