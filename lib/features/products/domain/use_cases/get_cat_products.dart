import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/products/domain/repositories/products_repositories.dart';

class GetCatProducts {
  late final ProductsRepositories repositories;

  GetCatProducts(this.repositories);

  // the call function will execute when use object of the class
  Future<List<ProductModel>?> call(int id) async {
    return await repositories.getcategoryProducts(id);
  }
}
