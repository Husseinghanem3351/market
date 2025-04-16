import 'package:market/features/sales/data/models/sale_model.dart';
import 'package:market/features/sales/domain/repositories/invoice_repositories.dart';


class GetReturnInvoicesUseCase{
  late final  InvoiceRepositories repositories;

  GetReturnInvoicesUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<List<InvoiceModel>? > call() async{
    return await repositories.getReturnInvoices();
  }
}