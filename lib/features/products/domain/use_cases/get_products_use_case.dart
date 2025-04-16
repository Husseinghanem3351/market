import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/products/domain/repositories/products_repositories.dart';

class GetProductsUseCase {
  late final ProductsRepositories repositories;

  GetProductsUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<List<ProductModel>?> call()  {
    return  repositories.getProducts();
  }
}
