import 'package:market/features/products/domain/repositories/products_repositories.dart';

class DeleteProductUseCase {
  late final ProductsRepositories repositories;

  DeleteProductUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(String id) async {
    return await repositories.deleteProduct(id);
  }
}
