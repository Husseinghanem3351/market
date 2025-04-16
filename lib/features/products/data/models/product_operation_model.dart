import 'package:market/features/products/domain/entities/ProductOperationEntity.dart';

class ProductOperationModel extends ProductOperationEntity {
  ProductOperationModel({
    required super.name,
    required super.price,
    required super.quantity,
    required super.operationType,
    required super.date,
  });
}
