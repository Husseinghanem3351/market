import 'package:market/features/sales/data/data_sources/sales_local_data_sources.dart';
import 'package:market/features/sales/data/models/sale_model.dart';

import '../../domain/repositories/sales_repositories.dart';

class SalesRepositoriesImplementation extends SalesRepositories {
  SalesLocalDataSources salesLocalDataSources=SalesLocalDataSourceImplementation();
  @override
  Future<void> addSales(SaleModel saleModel) async {
    salesLocalDataSources.addSale(saleModel);
  }

  @override
  Future<void> deleteSale(SaleModel id,) async {
    salesLocalDataSources.deleteSale(id);
  }


  @override
  Future<void> updateSale(SaleModel saleModel) async {
    salesLocalDataSources.updateSale(saleModel);
  }

  @override
  Future<List<SaleModel>?> getProductSales(String productId) async{
   return await salesLocalDataSources.getSalesProduct(productId);
  }
}
