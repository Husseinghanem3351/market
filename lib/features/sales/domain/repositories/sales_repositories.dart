import '../../data/models/sale_model.dart';

abstract class SalesRepositories {
  Future<void> addSales(SaleModel saleModel);
  Future<void> updateSale(SaleModel saleModel);
  Future<void> deleteSale(SaleModel id,);
  Future<List<SaleModel>?> getProductSales(String productId);
}