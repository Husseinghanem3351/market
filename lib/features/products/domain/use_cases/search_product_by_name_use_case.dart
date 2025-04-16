import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/products/domain/repositories/products_repositories.dart';

class SearchProductByNameUseCase {
  late final ProductsRepositories repositories;

  SearchProductByNameUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<List<ProductModel>?> call(String name) async {
    return await repositories.searchProductsByName(name);
  }
}
