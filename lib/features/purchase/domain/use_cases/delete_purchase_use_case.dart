import '../repositories/purchases_repositories.dart';

class DeletePurchaseUseCase {
  late final PurchasesRepositories repositories;

  DeletePurchaseUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(int id) async {
    return await repositories.deletePurchase(id);
  }
}
