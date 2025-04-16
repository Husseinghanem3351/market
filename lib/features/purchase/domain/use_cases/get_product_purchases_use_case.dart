import 'package:market/features/purchase/data/models/purchase_model.dart';

import '../repositories/purchases_repositories.dart';

class GetProductPurchasesUseCase {
  late final PurchasesRepositories repositories;

  GetProductPurchasesUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<List<PurchaseModel>?> call(String productId) async {
    return await repositories.getProductPurchases(productId);
  }
}
