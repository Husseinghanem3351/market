import 'package:market/features/purchase/data/models/purchase_model.dart';

import '../repositories/purchases_repositories.dart';

class UpdatePurchaseUseCase {
  late final PurchasesRepositories repositories;

  UpdatePurchaseUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(PurchaseModel purchaseModel) async {
    return await repositories.updatePurchase(purchaseModel);
  }
}
