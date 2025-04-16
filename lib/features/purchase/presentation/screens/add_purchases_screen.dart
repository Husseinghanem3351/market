import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/purchase/data/models/purchase_model.dart';
import 'package:market/features/purchase/presentation/cubit/cubit.dart';
import 'package:market/features/purchase/presentation/cubit/states.dart';
import 'package:market/features/purchase/presentation/screens/add_existing_products.dart';
import 'package:market/global/global_methods.dart';
import 'package:market/global/widgets/default_button.dart';
import 'package:market/global/widgets/default_text_form_field.dart';

class AddPurchasesScreen extends StatelessWidget {
  const AddPurchasesScreen({super.key, required this.addExistingProduct});

  static TextEditingController sellingPriceController = TextEditingController();
  static TextEditingController buyingPriceController = TextEditingController();
  static TextEditingController productIdController = TextEditingController();
  static TextEditingController quantityController = TextEditingController();
  static TextEditingController productNameController = TextEditingController();
  static TextEditingController dollarPriceController = TextEditingController();
  static TextEditingController packageController = TextEditingController();
  static TextEditingController packagePriceController = TextEditingController();
  static FocusNode focusNode = FocusNode();
  final bool addExistingProduct;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PurchasesCubit, PurchaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        focusNode.requestFocus();
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                if(!addExistingProduct)
                DefaultButton(
                  onPressed: () {
                    navigateTo(context, const AddExistingProduct());
                  },
                  textBtn: 'اضافة منتج موجود',
                ),
              ],
              leading: IconButton(
                onPressed: () {
                   sellingPriceController.clear();
                   buyingPriceController.clear();
                   productIdController.clear();
                   quantityController.clear();
                   productNameController.clear();
                   dollarPriceController.clear();
                   packageController.clear();
                   packagePriceController.clear();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
            body: Center(
              child: SizedBox(
                width: width / 2,
                height: height / 1.5,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                       DefaultFormField(
                        focusNode: focusNode,
                        controller: productIdController,
                        hintText: 'الباركود',
                      ),
                      // IconButton(onPressed: () {
                      //   PurchasesCubit.get(context).addBarcode();
                      // }, icon: const Icon(Icons.add,)),
                      DefaultFormField(
                        controller: quantityController,
                        hintText: 'الكمبة',
                      ),
                      DefaultFormField(
                        controller: buyingPriceController,
                        hintText: 'شعر الشراء',
                      ),
                      DefaultFormField(
                        controller: sellingPriceController,
                        hintText: 'سعر المبيع',
                      ),
                      DefaultFormField(
                        controller: productNameController,
                        hintText: 'اسم المنتج',
                      ),
                      DefaultFormField(
                        controller: packageController,
                        hintText: 'كمية الطرد',
                      ),
                      DefaultFormField(
                        controller: packagePriceController,
                        hintText: 'سعر الطرد',
                      ),
                      DefaultFormField(
                        controller: dollarPriceController,
                        hintText: 'سعر المبيع بالدولار',
                      ),
                      DefaultButton(
                        onPressed: () {
                          focusNode.requestFocus();
                          PurchasesCubit.get(context).addPurchase(
                            PurchaseModel(
                              productId: productIdController.text,
                              quantity: double.parse(quantityController.text),
                              buyingPrice:
                                  double.parse(buyingPriceController.text),
                              sellingPrice:
                                  double.parse(sellingPriceController.text),
                              productName: productNameController.text,
                              userName: 'hussein',
                              dateAndTime: DateTime.now().toString(),
                              dollarPrice:
                                  double.tryParse(dollarPriceController.text),
                              package: int.tryParse(packageController.text),
                              packagePrice:
                                  double.tryParse(packagePriceController.text),
                            ),
                          );
                          if(addExistingProduct) {
                            Navigator.of(context).pop();
                          }
                          productIdController.clear();
                          quantityController.clear();
                          sellingPriceController.clear();
                          buyingPriceController.clear();
                          productNameController.clear();
                          packageController.clear();
                          dollarPriceController.clear();
                          packagePriceController.clear();
                        },
                        textBtn: 'اضافة عملية شراء',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
