import 'package:market/features/products/data/data_sources/products_local_data_source.dart';
import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/sales/data/models/sale_model.dart';
import 'package:market/global/database.dart';

// each sale has one product invoice number
// each invoice has just id and dateTime
// so we get invoices, and then for each invoice we will get products

abstract class SalesLocalDataSources {
  Future<void> addSale(SaleModel saleModel);

  Future<List<SaleModel>?> getSalesInvoice(int invoiceNumber);
  Future<List<SaleModel>?> getReturnSalesInvoice(int invoiceNumber);

  Future<List<SaleModel>?> getSalesProduct(String productId);

  Future<void> deleteSale(
    SaleModel saleModel,
  );

  Future<void> updateSale(SaleModel saleModel);

  Future<void> deleteInvoiceSales(int invoiceId);
}

class SalesLocalDataSourceImplementation implements SalesLocalDataSources {
  ProductsLocalDataSource productsLocalDataSource =
      ProductsLocalDataSourceImplementation();

  @override
  Future<void> addSale(SaleModel saleModel) async {
    try {
      ProductModel? productModel = await productsLocalDataSource.searchProduct(
        saleModel.productId,
      );
      productModel?.quantity -= saleModel.quantity;

      productsLocalDataSource.updateProduct(productModel!);
      await database.transaction(
        (txn) => txn.insert(
          'salesNew',
          saleModel.toJson(),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> deleteSale(
    SaleModel saleModel,
  ) async {
    try {
      ProductModel? productModel =
          await productsLocalDataSource.searchProduct(saleModel.productId);
      productModel?.quantity += saleModel.quantity;
      productsLocalDataSource.updateProduct(productModel!);
      await database.transaction(
            (txn) => txn.insert(
          'returnSales',
          saleModel.toJson(),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<List<SaleModel>?> getSalesInvoice(int invoiceNumber) async {
    try {
      final value = await database
          .rawQuery('select * from salesNew where saleInvoice=$invoiceNumber');

      return value.map<SaleModel>((element) {
        return SaleModel.fromJson(element);
      }).toList();
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Future<void> updateSale(SaleModel saleModel) async {
    try {
      database.rawUpdate('update salesNew set '
          'quantity=${saleModel.quantity},'
          'price=${saleModel.price}'
          'where id=${saleModel.id}');
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> deleteInvoiceSales(int invoiceId) async {
    try {
      List<SaleModel>? sales = await getSalesInvoice(invoiceId);
      sales?.forEach(
        (element) async {
          ProductModel? productModel =
              await productsLocalDataSource.searchProduct(element.productId);
          productModel?.quantity += element.quantity;
          productsLocalDataSource.updateProduct(productModel!);
        },
      );
      await database.rawDelete(
        'delete from salesNew where saleInvoice = $invoiceId',
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<List<SaleModel>?> getSalesProduct(String productId) async {
    try {
      final value = await database
          .rawQuery('select * from salesNew where productId = "$productId"');


      return value.map<SaleModel>((element) {
        return SaleModel.fromJson(element);
      }).toList();
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Future<List<SaleModel>?> getReturnSalesInvoice(int invoiceNumber)async {
    try {
      final value = await database
          .rawQuery('select * from returnSales where saleInvoice = $invoiceNumber');

      return value.map<SaleModel>((element) {
        return SaleModel.fromJson(element);
      }).toList();
    } catch (error) {
      print(error);
    }
    return null;
  }
}