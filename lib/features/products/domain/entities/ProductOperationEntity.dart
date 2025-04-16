class ProductOperationEntity {
  final double quantity;
  final double price;
  final String operationType;
  final String? date;
  final String name;


  ProductOperationEntity({
    required this.name,
    required this.price,
    required this.quantity,
    required this.operationType,
    required this.date,
  });
}