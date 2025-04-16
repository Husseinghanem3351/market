
import 'package:market/features/products/data/data_sources/products_local_data_source.dart';
import 'package:market/features/sales/data/data_sources/sales_local_data_sources.dart';
import 'package:market/features/sales/data/models/sale_model.dart';
import 'package:market/features/sales/presentation/screens/day_invoices_screen.dart';
import 'package:market/features/sales/presentation/screens/invoices.dart';
import '../../../../global/database.dart';
import '../../../products/data/models/product_model.dart';

// we need to get invoices and after this we will get sales for each one

abstract class InvoicesLocalDataSource {
  Future<void> addInvoice(InvoiceModel invoice);

  Future<(List<InvoiceModel>?, List<InvoiceModel>?, List<String>?)?>
      getInvoices();

  Future<void> deleteInvoice(int id);

  Future<List<InvoiceModel>> getDayInvoices(String date);

  Future<String> getDateSale(int invoiceNumber);

  Future<void> updateInvoice(InvoiceModel invoice);

  Future<void> addReturnInvoice(InvoiceModel invoice);
  Future<List<InvoiceModel>> getReturnInvoice();

}

class InvoiceLocalDataSourceImplementation implements InvoicesLocalDataSource {
  SalesLocalDataSources salesLocalDataSources =
      SalesLocalDataSourceImplementation();
  ProductsLocalDataSource productsLocalDataSource =
      ProductsLocalDataSourceImplementation();
  List<SaleModel>? sales = [];

  @override
  Future<void> addInvoice(InvoiceModel invoice) async {
    try {
      sales = List.from(invoice.sales as Iterable);
      int saleInvoiceId = await database.transaction(
        (txn) => txn.insert(
          'salesInvoicesNew',
          invoice.toJson(),
        ),
      );
      for (var element in sales!) {
        element.saleInvoice = saleInvoiceId;
        salesLocalDataSources.addSale(element);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> deleteInvoice(int id) async {
    try {
      if (sales != null) {
        salesLocalDataSources.deleteInvoiceSales(id);
      }
      await database.rawDelete(
        'delete from salesInvoicesNew where id =$id',
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<
      (
        List<InvoiceModel>? invoices,
        List<InvoiceModel>? todayInvoices,
        List<String>? dates
      )?> getInvoices() async {
    try {
      final allInvoices =
          await database.rawQuery('select * from salesInvoicesNew');
      final todayInvoices = await database.rawQuery(
          'select * from salesInvoicesNew where dateAndTime like"${DateTime.now().toString().substring(0, 10)}%"');
      final dates =
          await database.rawQuery('select dateAndTime from salesInvoicesNew');
      var invoices = allInvoices.map<InvoiceModel>((e) {
        InvoiceModel invoiceModel = InvoiceModel.fromJson(e);
        return invoiceModel;
      }).toList();
      List<InvoiceModel> todayInvoicesVar = [];
      for (var element in todayInvoices) {
        InvoiceModel invoiceModel = InvoiceModel.fromJson(element);
        todayInvoicesVar.add(invoiceModel);

        invoiceModel.sales =
            await salesLocalDataSources.getSalesInvoice(invoiceModel.id!);
        for (var element in invoiceModel.sales!) {
          ProductModel? product = await productsLocalDataSource
              .searchProduct(element.productId);

          Invoices.reward += (product!.sellingPrice - product.buyingPrice) *
              element.quantity;
        }
        Invoices.reward -= invoiceModel.discount;
        Invoices.total+=invoiceModel.price;
        Invoices.total-=invoiceModel.discount;
      }
      List<String> datesVar = [];
      for (int i = 0; i < dates.length; i++) {
        String date = dates[i]['dateAndTime'].toString();
        date = date.substring(0, 10);
        if (i == 0) {
          datesVar.add(date);
        } else if (datesVar.last != date) {
          datesVar.add(date);
        }
      }
      return (invoices, todayInvoicesVar, datesVar);
    } catch (error) {
      print(error);
    }
    return null;
    // List<SaleModel> sales=await salesLocalDataSources.getSalesInvoice(id);
  }

  @override
  Future<void> updateInvoice(InvoiceModel invoice) async {
    try {
      database.rawUpdate('update salesInvoicesNew set '
          'price=${invoice.price},'
          'where id=${invoice.id}');
      var sales =
          await salesLocalDataSources.getSalesInvoice(invoice.id!) ?? [];
      for (SaleModel saleItem in sales) {
        await salesLocalDataSources.updateSale(saleItem);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<List<InvoiceModel>> getDayInvoices(String date) async {
    final value = await database.rawQuery(
        'select * from salesInvoicesNew where dateAndTime like "$date%"');
    final returnInvoices =
    await database.rawQuery('select * from returnSalesInvoice where dateAndTime like "$date%"');
    for(var element in returnInvoices){
      InvoiceModel invoiceModel=InvoiceModel.fromJson(element);
      invoiceModel.sales =
      await salesLocalDataSources.getSalesInvoice(invoiceModel.id!);
      for (var element in invoiceModel.sales!) {
        ProductModel? product =
        await productsLocalDataSource.searchProduct(element.productId);
        if(product!=null) {
          DayInvoicesScreen.reward -=
              (product.sellingPrice  - product.buyingPrice) *
                  element.quantity;
        }
      }
      DayInvoicesScreen.reward += invoiceModel.discount;
      DayInvoicesScreen.total += invoiceModel.discount;
      DayInvoicesScreen.total -= invoiceModel.price;
    }
    List<InvoiceModel> dayInvoices = [];
    for (var element in value) {
      InvoiceModel invoiceModel = InvoiceModel.fromJson(element);
      dayInvoices.add(invoiceModel);

      invoiceModel.sales =
          await salesLocalDataSources.getSalesInvoice(invoiceModel.id!);
      for (var element in invoiceModel.sales!) {
        ProductModel? product =
            await productsLocalDataSource.searchProduct(element.productId);
        if(product!=null) {
          DayInvoicesScreen.reward +=
              (product.sellingPrice  - product.buyingPrice) *
                  element.quantity;
        }
      }
      DayInvoicesScreen.reward -= invoiceModel.discount;
      DayInvoicesScreen.total -= invoiceModel.discount;
      DayInvoicesScreen.total += invoiceModel.price;
    }
    return dayInvoices;
  }

  @override
  Future<String> getDateSale(int invoiceNumber) async {
    final  value = await database.rawQuery(
        'select dateAndTime from salesInvoicesNew where id = $invoiceNumber') ;
    return value[0]['dateAndTime'].toString();
  }

  @override
  Future<void> addReturnInvoice(InvoiceModel invoice)async {
    sales = List.from(invoice.sales as Iterable);
    int saleInvoiceId = await database.transaction(
          (txn) => txn.insert(
        'returnSalesInvoice',
        invoice.toJson(),
      ),
    );
    for (var element in sales!) {
      element.saleInvoice = saleInvoiceId;
      salesLocalDataSources.deleteSale(element);
    }}

  @override
  Future<List<InvoiceModel>> getReturnInvoice() async{
    final allInvoices =
        await database.rawQuery('select * from returnSalesInvoice');
    List<InvoiceModel> invoices=[];
    for (var element in allInvoices) {
      InvoiceModel invoiceModel = InvoiceModel.fromJson(element);
      invoiceModel.sales=await salesLocalDataSources.getReturnSalesInvoice(invoiceModel.id!);
      if(invoiceModel.dateAndTime.toString().substring(0,10)==DateTime.now().toString().substring(0,10)){
        for (var element in invoiceModel.sales!) {
          ProductModel? product = await productsLocalDataSource
              .searchProduct(element.productId);

          Invoices.reward -= (product!.sellingPrice - product.buyingPrice) *
              element.quantity;
        }
        Invoices.reward += invoiceModel.discount;
        Invoices.total-=invoiceModel.price;
        Invoices.total+=invoiceModel.discount;
      }
      invoices.add(invoiceModel);
    }
    return invoices;
  }


}
