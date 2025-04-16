import 'package:market/features/purchase/data/models/purchase_model.dart';

import '../repositories/purchases_repositories.dart';

class AddPurchaseUseCase {
  late final PurchasesRepositories repositories;

  AddPurchaseUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(PurchaseModel purchaseModel) async {
    return await repositories.addPurchase(purchaseModel);
  }
}
