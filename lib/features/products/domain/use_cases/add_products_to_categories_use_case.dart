
import 'package:market/features/products/domain/repositories/products_repositories.dart';

class AddProductsToCategoriesUseCase {
  late final ProductsRepositories repositories;

  AddProductsToCategoriesUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(List<String> productsId, int categoryId) async {
    return await repositories.addProductsToCategories(productsId,categoryId);
  }
}
