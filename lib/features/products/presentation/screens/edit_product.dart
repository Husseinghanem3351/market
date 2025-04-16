import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/products/presentation/cubit/cubit.dart';
import 'package:market/features/purchase/presentation/cubit/cubit.dart';
import 'package:market/features/purchase/presentation/cubit/states.dart';
import 'package:market/global/widgets/default_button.dart';
import 'package:market/global/widgets/default_text_form_field.dart';

class EditProduct extends StatelessWidget {
  const EditProduct({super.key, required this.productModel});

  final ProductModel productModel;
  static TextEditingController sellingPriceController = TextEditingController();
  static TextEditingController buyingPriceController = TextEditingController();
  static TextEditingController productIdController = TextEditingController();
  static TextEditingController quantityController = TextEditingController();
  static TextEditingController productNameController = TextEditingController();
  static TextEditingController dollarPriceController = TextEditingController();
  static TextEditingController packageController = TextEditingController();
  static TextEditingController packagePriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PurchasesCubit, PurchaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('تعديل منتج'),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            ProductsCubit.get(context)
                                .deleteProduct(productModel.id,context);
                          },
                          icon: const Icon(Icons.delete)),
                      DefaultFormField(
                        controller: productIdController,
                        hintText: 'الباركود',
                      ),
                      DefaultFormField(
                        controller: quantityController,
                        hintText: 'الكمية',
                      ),
                      DefaultFormField(
                        controller: buyingPriceController,
                        hintText: 'سعر الشراء',
                      ),
                      DefaultFormField(
                        controller: sellingPriceController,
                        hintText: 'سعر البيع',
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
                        hintText: 'سعر البيع بالدولار',
                      ),
                      DefaultButton(
                        onPressed: () {
                          ProductsCubit.get(context).editProduct(
                            ProductModel(
                                id: productIdController.text,
                                quantity: double.parse(quantityController.text),
                                buyingPrice:
                                    double.parse(buyingPriceController.text),
                                sellingPrice:
                                    double.parse(sellingPriceController.text),
                                name: productNameController.text,
                                dollarPrice:
                                    double.tryParse(dollarPriceController.text),
                                packageQuantity:
                                    packageController.text.isNotEmpty
                                        ? int.tryParse(packageController.text)
                                        : null,
                                packagePrice: double.tryParse(
                                  packagePriceController.text,
                                )),
                          );
                          productIdController.clear();
                          quantityController.clear();
                          sellingPriceController.clear();
                          buyingPriceController.clear();
                          productNameController.clear();
                          dollarPriceController.clear();
                          packageController.clear();
                          packagePriceController.clear();
                          Navigator.pop(context);
                        },
                        textBtn: 'حفظ التعديل',
                      )
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
