import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/products/data/repositories/products_repositories_implementation.dart';
import 'package:market/features/products/domain/use_cases/search_product_use_case.dart';
import 'package:market/features/purchase/data/models/purchase_model.dart';
import 'package:market/global/database.dart';

// each sale has one product invoice number
// each invoice has just id and dateTime
// so we get invoices, and then for each invoice we will get products

abstract class PurchaseLocalDataSources {
  Future<void> addPurchase(PurchaseModel purchaseModel);

  Future<List<PurchaseModel>?> getPurchases();

  Future<List<PurchaseModel>?> getProductPurchases(String productId);

  Future<void> deletePurchase(int id);

  Future<void> updatePurchase(PurchaseModel purchaseModel);
}

class PurchaseLocalDataSourceImplementation
    implements PurchaseLocalDataSources {
  @override
  Future<void> addPurchase(PurchaseModel purchaseModel) async {
    SearchProductUseCase searchProductUseCase =
        SearchProductUseCase(ProductsRepositoriesImplementation());
    try {
      ProductModel? product =
          await searchProductUseCase(purchaseModel.productId);
      if (product == null) {
        database.transaction((txn) async {
          await txn.insert(
            'productsNew',
            ProductModel(
              packagePrice: purchaseModel.packagePrice,
              id: purchaseModel.productId,
              name: purchaseModel.productName,
              quantity: purchaseModel.quantity,
              buyingPrice: purchaseModel.buyingPrice,
              sellingPrice: purchaseModel.sellingPrice,
              packageQuantity: purchaseModel.package,
              dollarPrice: purchaseModel.dollarPrice,
            ).toJson(),
          );
        });
      } else {
        database.transaction((txn) async {
          database.rawUpdate('update productsNew set '
              'quantity=${purchaseModel.quantity + product.quantity},'
              'buyingPrice=${purchaseModel.buyingPrice},'
              'sellingPrice=${purchaseModel.sellingPrice},'
              'dollarPrice=${purchaseModel.dollarPrice},'
              'packageQuantity=${purchaseModel.package},'
              'packagePrice=${purchaseModel.packagePrice} '
              'where id = "${purchaseModel.productId}"');
        });
      }
      database.transaction(
        (txn) => txn.insert(
          'purchaseNew',
          purchaseModel.toJson(),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> deletePurchase(int id) async {
    try {
      database.rawDelete(
        'delete from purchaseNew where id =$id',
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<List<PurchaseModel>?> getPurchases() async {
    try {
      final value = await database.rawQuery('select * from purchaseNew');
      // await database.rawQuery('delete from salesNew where id>0');
      // value.forEach((element) {
      //   PurchaseModel purchaseModel=PurchaseModel.fromJson(element);
      //   database.insert('purchaseNew', purchaseModel.toJson());
      // },);
      return value
          .map<PurchaseModel>((e) => PurchaseModel.fromJson(e))
          .toList();
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Future<List<PurchaseModel>?> getProductPurchases(String productId) async {
    try {
      final value = await database.rawQuery('select * from purchaseNew where productId = "$productId"');
      // await database.rawQuery('delete from salesNew where id>0');
      // value.forEach((element) {
      //   PurchaseModel purchaseModel=PurchaseModel.fromJson(element);
      //   database.insert('purchaseNew', purchaseModel.toJson());
      // },);
      return value
          .map<PurchaseModel>((e) => PurchaseModel.fromJson(e))
          .toList();
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Future<void> updatePurchase(PurchaseModel purchaseModel) async {
    try {
      database.rawUpdate('update purchaseNew set '
          'quantity=${purchaseModel.quantity},'
          'buyingPrice=${purchaseModel.buyingPrice}'
          'sellingPrice=${purchaseModel.sellingPrice}'
          'productId=${purchaseModel.productId}'
          'where id=${purchaseModel.id}');
    } catch (error) {
      print(error);
    }
  }
}
