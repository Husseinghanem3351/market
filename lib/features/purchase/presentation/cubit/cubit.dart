import 'package:market/features/purchase/data/models/purchase_model.dart';
import 'package:market/features/purchase/presentation/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global/global_methods.dart';
import '../../../../global/use_cases.dart';
import '../screens/purchases_screen.dart';

class PurchasesCubit extends Cubit<PurchaseStates> {
  PurchasesCubit() : super(InitPurchaseState());

  static PurchasesCubit get(context) => BlocProvider.of(context);

  List<PurchaseModel> purchases = [];

  Future<void> addPurchase(PurchaseModel purchaseModel) async {
    PurchasesUseCases.addPurchaseUseCase(
        purchaseModel); // this will add tp products then purchases

    emit(AddPurchaseSuccessState());
  }

  Future<void> getPurchases() async {
    // this will add tp products then purchases
    purchases = (await PurchasesUseCases.getPurchasesUseCase())??[];
    purchases.sort((a, b) => DateTime.parse(b.dateAndTime).compareTo(DateTime.parse(a.dateAndTime)),);
    emit(GetPurchasesSuccessState());
  }

  Future<void> navigateToPurchases(context)async{
   await getPurchases();
    navigateTo(context, const PurchasesScreen());
  }
  // Future<void> addBarcode() async {
  //   // this will add tp products then purchases
  //   AddPurchasesScreen.productIdControllers.add(TextEditingController());
  //   emit(AddBarcodeState());
  // }


}
