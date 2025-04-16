import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/products/domain/repositories/products_repositories.dart';

class SearchProductUseCase {
  late final ProductsRepositories repositories;

  SearchProductUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<ProductModel?> call(String id) async {
    return await repositories.searchProduct(id);
  }
}
