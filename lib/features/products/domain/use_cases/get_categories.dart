import 'package:market/features/products/domain/entities/category.dart';
import 'package:market/features/products/domain/repositories/products_repositories.dart';

class GetCategories {
  late final ProductsRepositories repositories;

  GetCategories(this.repositories);

  // the call function will execute when use object of the class
  Future<List<CategoryEntity>?> call()  {
    return  repositories.getCategories();
  }
}
