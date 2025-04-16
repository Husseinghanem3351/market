

import 'package:market/features/sales/data/models/sale_model.dart';
import 'package:market/features/sales/domain/repositories/invoice_repositories.dart';

class AddInvoiceUseCase{
  late final  InvoiceRepositories repositories;

  AddInvoiceUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(InvoiceModel invoiceModel) async{
    return await repositories.addInvoice(invoiceModel);
  }
}