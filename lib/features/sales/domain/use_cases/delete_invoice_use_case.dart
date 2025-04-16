import 'package:market/features/sales/domain/repositories/invoice_repositories.dart';

class DeleteInvoiceUseCase {
  late final InvoiceRepositories repositories;

  DeleteInvoiceUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(int id) async {
    return await repositories.deleteInvoice(id);
  }
}
