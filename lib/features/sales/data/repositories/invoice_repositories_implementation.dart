import 'package:market/features/sales/data/data_sources/invoices_local_data_source.dart';
import 'package:market/features/sales/data/models/sale_model.dart';
import 'package:market/features/sales/domain/repositories/invoice_repositories.dart';

class InvoiceRepositoriesImplementation implements InvoiceRepositories {
  InvoicesLocalDataSource invoicesLocalDataSource =
      InvoiceLocalDataSourceImplementation();

  @override
  Future<void> addInvoice(InvoiceModel invoiceModel) async {
    invoicesLocalDataSource.addInvoice(invoiceModel);
  }

  @override
  Future<void> addReturnInvoice(InvoiceModel invoiceModel) async {
    invoicesLocalDataSource.addReturnInvoice(invoiceModel);
  }
  @override
  Future<void> deleteInvoice(int id) async {
    invoicesLocalDataSource.deleteInvoice(id);
  }

  @override
  Future<(List<InvoiceModel>?, List<InvoiceModel>?, List<String>?)?> getInvoices() async {
    return await invoicesLocalDataSource.getInvoices();
  }

  @override
  Future<void> updateInvoice(InvoiceModel invoiceModel) async {
    invoicesLocalDataSource.updateInvoice(invoiceModel);
  }

  @override
  Future<List<InvoiceModel>> getDayInvoice(String date) async {
   return invoicesLocalDataSource.getDayInvoices(date);
  }

  @override
  Future<String> getSaleDate(int invoiceNumber) {
    return invoicesLocalDataSource.getDateSale(invoiceNumber);
  }

  @override
  Future<List<InvoiceModel>> getReturnInvoices() {
    return invoicesLocalDataSource.getReturnInvoice();
  }

}
