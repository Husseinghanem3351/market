import 'package:market/features/products/domain/entities/category.dart';
import 'package:market/features/products/domain/repositories/products_repositories.dart';

class AddCategoryUseCase {
  late final ProductsRepositories repositories;

  AddCategoryUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<int> call(CategoryEntity category) async {
    return await repositories.addCategory(category);
  }
}
