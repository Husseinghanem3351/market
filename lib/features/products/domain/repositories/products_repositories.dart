import 'package:market/features/products/domain/entities/category.dart';

import '../../data/models/product_model.dart';

abstract class ProductsRepositories {
  Future<void> addProduct(ProductModel product);

  Future<List<ProductModel>?> getProducts();

  Future<ProductModel?> searchProduct(String id);

  Future<void> updateProduct(ProductModel product);

  Future<void> deleteProduct(String id);

  Future<List<ProductModel>?> searchProductsByName(String name);

  Future<List<ProductModel>?> getcategoryProducts(int id);

  Future<List<CategoryEntity>?> getCategories();

  Future<int> addCategory(CategoryEntity category);

  Future<void> addProductsToCategories(List<String> productsId, int categoryId);
}
