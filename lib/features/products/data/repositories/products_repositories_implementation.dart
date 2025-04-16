
import 'package:market/features/products/data/data_sources/products_local_data_source.dart';
import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/products/domain/entities/category.dart';
import '../../domain/repositories/products_repositories.dart';

class ProductsRepositoriesImplementation extends ProductsRepositories {
  ProductsLocalDataSource productsLocalDataSource =
      ProductsLocalDataSourceImplementation();

  @override
  Future<void> addProduct(ProductModel product) async {
    productsLocalDataSource.addProduct(product);
  }

  @override
  Future<void> deleteProduct(String id) async {
    productsLocalDataSource.deleteProduct(id);
  }

  @override
  Future<List<ProductModel>?> getProducts() async {
    return await productsLocalDataSource.getProducts();
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    productsLocalDataSource.updateProduct(product);
  }

  @override
  Future<ProductModel?> searchProduct(String id) async {
    return await productsLocalDataSource.searchProduct(id);
  }

  @override
  Future<List<ProductModel>?> searchProductsByName(String name) async{
    return await productsLocalDataSource.searchProductByName(name);
  }

  @override
  Future<List<ProductModel>?> getcategoryProducts(int id) async {
    return await productsLocalDataSource.getCategoryProducts(id);
  }

  @override
  Future<List<CategoryEntity>?> getCategories()async {
    return await productsLocalDataSource.getCategories();
  }

  @override
  Future<int> addCategory(CategoryEntity category) async {
   return await productsLocalDataSource.addCategory(category);
  }

  @override
  Future<void> addProductsToCategories(List<String> productsId, int categoryId) async {
    await productsLocalDataSource.addProductsToCategories(productsId, categoryId);
  }
}
