import 'package:market/features/purchase/data/models/purchase_model.dart';

import '../repositories/purchases_repositories.dart';

class GetPurchasesUseCase {
  late final PurchasesRepositories repositories;

  GetPurchasesUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<List<PurchaseModel>?> call() async {
    return await repositories.getPurchases();
  }
}
