import 'package:market/features/sales/data/models/sale_model.dart';
import 'package:market/features/sales/domain/repositories/sales_repositories.dart';


class GetProductSalesUseCase{
  late final  SalesRepositories repositories;

  GetProductSalesUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<List<SaleModel>?> call(String productId) async{
    return await repositories.getProductSales(productId);
  }
}