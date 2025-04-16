import 'package:market/features/sales/data/models/sale_model.dart';

abstract class InvoiceRepositories {
  Future<(List<InvoiceModel>? allInvoices, List<InvoiceModel>? todayInvoices, List<String>? dates)?> getInvoices();
  Future<void> deleteInvoice(int id);
  Future<void> updateInvoice(InvoiceModel invoiceModel);
  Future<void> addInvoice(InvoiceModel invoiceModel);
  Future<void> addReturnInvoice(InvoiceModel invoiceModel);
  Future<List<InvoiceModel>> getDayInvoice(String date);
  Future<String> getSaleDate(int invoiceNumber);
  Future<List<InvoiceModel>> getReturnInvoices();

}