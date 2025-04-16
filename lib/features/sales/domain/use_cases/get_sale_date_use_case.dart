import 'package:market/features/sales/domain/repositories/invoice_repositories.dart';

class GetSaleDateUseCase {
  late final InvoiceRepositories repositories;

  GetSaleDateUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<String> call(int invoiceNumber) async {
    return await repositories.getSaleDate(invoiceNumber);
  }
}
