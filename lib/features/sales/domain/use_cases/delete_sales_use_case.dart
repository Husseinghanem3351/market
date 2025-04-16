

import 'package:market/features/sales/data/models/sale_model.dart';
import 'package:market/features/sales/domain/repositories/sales_repositories.dart';


class DeleteSalesUseCase{
  late final  SalesRepositories repositories;

  DeleteSalesUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(SaleModel saleModel,) async{
    return await repositories.deleteSale(saleModel);
  }
}