import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/products/domain/repositories/products_repositories.dart';

class EditProductUseCase {
  late final ProductsRepositories repositories;

  EditProductUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(ProductModel product) async {
    return await repositories.updateProduct(product);
  }
}
