import 'package:market/features/sales/data/models/sale_model.dart';

import '../repositories/invoice_repositories.dart';

class GetInvoicesDayUseCase {
  late final  InvoiceRepositories repositories;

  GetInvoicesDayUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<List<InvoiceModel>> call(String date) async{
    return await repositories.getDayInvoice(date);
  }
}