import '../../data/models/purchase_model.dart';

abstract class PurchasesRepositories
{
  Future<void> addPurchase(PurchaseModel purchaseModel);
  Future<List<PurchaseModel>?> getPurchases();
  Future<List<PurchaseModel>?> getProductPurchases(String productId);
  Future<void> updatePurchase(PurchaseModel purchaseModel);
  Future<void> deletePurchase(int id);
}