import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/products/domain/entities/category.dart';
import 'package:market/features/purchase/data/data_sources/purchase_local_data_sources.dart';

import '../../../../global/database.dart';

// we need to get products and after this we will get sales for each one

abstract class ProductsLocalDataSource {
  Future<void> addProduct(ProductModel product);

  Future<List<ProductModel>?> getProducts();

  Future<ProductModel?> searchProduct(String id);

  Future<List<ProductModel>?> searchProductByName(String name);

  Future<void> deleteProduct(String id);

  Future<void> updateProduct(ProductModel product);

  Future<List<ProductModel>?> getCategoryProducts(int categoryId);

  Future<List<CategoryEntity>?> getCategories();

  Future<int> addCategory(CategoryEntity category);
  Future<void> editCategory(CategoryEntity category);
  Future<void> deleteCategory(int catId);

  Future<void> addProductsToCategories(List<String> productsId, int categoryId);
}

class ProductsLocalDataSourceImplementation implements ProductsLocalDataSource {
  PurchaseLocalDataSources purchaseLocalDataSources =
      PurchaseLocalDataSourceImplementation();

  @override
  Future<void> addProduct(ProductModel product) async {
    try {

      await database.transaction(
        (txn) => txn.insert(
          'productsNew',
          product.toJson(),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      // database.rawDelete('delete from productsBarcodes where id = "$id"');
      database.rawDelete(
        'delete from productsNew where id = "$id"',
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<List<ProductModel>?> getProducts() async {
    try {
      final value = await database.rawQuery('select * from productsNew');
      List<ProductModel> products = [];
      for (var element in value) {
        ProductModel productModel = ProductModel.fromJson(element);
        // final barcodesValue = await database.rawQuery(
        //     'select productId from productsBarcodes where id= ${productModel.id}');
        // print('barcodes $barcodesValue');
        // List<String> barcodes = barcodesValue
        //     .map<String>(
        //       (e) => e['productId'].toString(),
        //     )
        //     .toList();
        // // productModel.barcodes = barcodes;
        products.add(productModel);
      }
      return products;
    } catch (error) {
      print(error);
    }
    return null;
    // List<SaleModel> sales=await salesLocalDataSources.getSalesInvoice(id);
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
      // database.rawDelete('delete from productsBarcodes where id = "${product.id}"');
      // for (var element in product.barcodes!) {
      //   await database.transaction((txn) => txn.insert(
      //     'productsBarcodes',
      //     {
      //       'productId': element,
      //       'id': product.id,
      //     },
      //   ));
      // }
      database.rawUpdate('update productsNew set '
          'buyingPrice=${product.buyingPrice},'
          'name="${product.name}",'
          'quantity=${product.quantity},'
          'packageQuantity=${product.packageQuantity},'
          'dollarPrice=${product.dollarPrice},'
          'packagePrice=${product.packagePrice},'
          'sellingPrice=${product.sellingPrice} '
          'where id="${product.id}"');
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<ProductModel?> searchProduct(String productId) async {
    try {
      // final barcode =  database.rawQuery(
      //     'select productId from productsBarcodes where productId= $productId').toString();

      final value = await database
          .rawQuery('select * from productsNew where id="$productId"');
      if (value.isNotEmpty) {
         ProductModel productModel= ProductModel.fromJson(value[0]);
        return productModel;
      }
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Future<List<ProductModel>?> searchProductByName(String name) async {
    try {
      final value = await database
          .rawQuery('select * from productsNew where name like "%$name%"');

      if (value.isNotEmpty) {
        List<ProductModel> products = [];
        for (var element in value) {
          ProductModel productModel = ProductModel.fromJson(element);
          // final barcodesValue = await database.rawQuery(
          //     'select productId from productsBarcodes where id= ${productModel.id}');
          // print('barcodes $barcodesValue');
          // List<String> barcodes = barcodesValue
          //     .map<String>(
          //       (e) => e['productId'].toString(),
          // )
          //     .toList();
          // productModel.barcodes = barcodes;
          products.add(productModel);
        }
        return products;
      }
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Future<List<ProductModel>?> getCategoryProducts(int categoryId) async {
    try {
      final value = await database
          .rawQuery('select * from productsNew where categoryId = $categoryId');

      if (value.isNotEmpty) {
        List<ProductModel> products = [];
        for (var element in value) {
          ProductModel productModel = ProductModel.fromJson(element);
          // final barcodesValue = await database.rawQuery(
          //     'select productId from productsBarcodes where id= ${productModel.id}');
          // print('barcodes $barcodesValue');
          // List<String> barcodes = barcodesValue
          //     .map<String>(
          //       (e) => e['productId'].toString(),
          // )
          //     .toList();
          // productModel.barcodes = barcodes;
          products.add(productModel);
        }
        return products;
      }
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Future<List<CategoryEntity>?> getCategories() async {
    try {
      final value = await database.rawQuery('select * from categories');

      if (value.isNotEmpty) {
        return value.map<CategoryEntity>((e) {
          return CategoryEntity(
              id: int.parse(e['id'].toString()),
              name: e['categoryName'].toString());
        }).toList();
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<int> addCategory(CategoryEntity category) async {
    int id = 0;
    try {
      id = await database.transaction(
        (txn) => txn.insert(
          'categories',
          {
            'categoryName': category.name,
          },
        ),
      );
    } catch (e) {
      print(e);
    }
    return id;
  }

  @override
  Future<void> addProductsToCategories(
      List<String> productsId, int categoryId) async {
    try {
      await database.rawUpdate('update productsNew set '
          'categoryId =$Null '
          'where categoryId="$categoryId"');
      for (var productId in productsId) {
        database.rawUpdate('update productsNew set '
            'categoryId =$categoryId '
            'where id="$productId"');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> deleteCategory(int catId)async {
    database.rawDelete(
      'delete from categories where id = "$catId"',
    );
    database.rawUpdate('update productsNew set '
        'categoryId= $Null '
        'where categoryId = $catId');
  }

  @override
  Future<void> editCategory(CategoryEntity category) async{
    database.rawUpdate('update categories set '
        'categoryName = "${category.name}" '
        'where id = ${category.id}');
  }

}
