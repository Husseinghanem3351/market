import 'package:market/features/sales/data/models/sale_model.dart';
import 'package:market/features/sales/domain/repositories/invoice_repositories.dart';


class GetInvoicesUseCase{
  late final  InvoiceRepositories repositories;

  GetInvoicesUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<(List<InvoiceModel>? , List<InvoiceModel>?, List<String>?)?> call() async{
    return await repositories.getInvoices();
  }
}