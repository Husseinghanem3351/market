import 'package:market/features/purchase/data/data_sources/purchase_local_data_sources.dart';
import 'package:market/features/purchase/data/models/purchase_model.dart';

import '../../domain/repositories/purchases_repositories.dart';

class PurchasesRepositoriesImplementation extends PurchasesRepositories {
  PurchaseLocalDataSources purchaseLocalDataSources=PurchaseLocalDataSourceImplementation();
  @override
  Future<void> addPurchase(PurchaseModel purchaseModel) async {
    purchaseLocalDataSources.addPurchase(purchaseModel);
  }

  @override
  Future<void> deletePurchase(int id) async {
    purchaseLocalDataSources.deletePurchase(id);
  }



  @override
  Future<void> updatePurchase(PurchaseModel purchaseModel) async {
    purchaseLocalDataSources.updatePurchase(purchaseModel);
  }

  @override
  Future<List<PurchaseModel>?> getPurchases() async {
   return  purchaseLocalDataSources.getPurchases();
  }

  @override
  Future<List<PurchaseModel>?> getProductPurchases(String productId) async {
    return  purchaseLocalDataSources.getProductPurchases(productId);
  }
}
