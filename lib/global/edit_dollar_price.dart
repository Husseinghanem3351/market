import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/products/presentation/cubit/cubit.dart';
import 'package:market/features/products/presentation/cubit/states.dart';
import 'package:market/global/widgets/default_button.dart';
import 'package:market/global/widgets/default_text_form_field.dart';
import 'package:market/global/widgets/edit_product_price_widget.dart';

class EditDollarPrice extends StatelessWidget {
  const EditDollarPrice({super.key});

  static bool isChange = false;
  static List<ProductModel> editingProducts = [];
  static double newDollarPrice = 0;

  @override
  Widget build(BuildContext context) {
    TextEditingController dollarController = TextEditingController();
    return BlocConsumer<ProductsCubit, ProductsStates>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            SizedBox(
              width: 300,
              child: DefaultFormField(
                controller: dollarController,
                labelText: 'سعر الدولار الجديد',
              ),
            ),
            DefaultButton(
              color: Colors.green,
              onPressed: () {
                newDollarPrice = double.parse(dollarController.text);
                editingProducts.clear();
                ProductsCubit.get(context).products?.forEach(
                  (element) {
                    if (element.dollarPrice != null) {
                      editingProducts.add(element);
                    }
                  },
                );
                ProductsCubit.get(context).changeDollarPrice();
              },
              textBtn: 'حفظ',
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('المنتج'),
                  Text('سعر الشراء'),
                  Text('سعر البيع الجديد'),
                ],
              ),
            ),
            if (isChange) ...[
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    double newPrice =
                        (newDollarPrice * editingProducts[index].dollarPrice!)
                            .roundToDouble();
                    if (newPrice % 500 != 0) {
                      newPrice -= newPrice % 500;
                    }
                    editingProducts.last.sellingPrice = newPrice;
                    return EditProductPriceWidget(
                      productModel: editingProducts[index],
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.green.withOpacity(.1),
                  ),
                  itemCount: editingProducts.length,
                ),
              ),
              DefaultButton(
                color: Colors.red,
                onPressed: () {
                  // insureDialog(context, 'text');
                  ProductsCubit.get(context).editProductsDollarPrice(
                    products: editingProducts,
                  );
                  Navigator.pop(context);
                },
                textBtn: 'حفظ التغييرات',
              ),
            ]
          ],
        ),
      ),
      listener: (context, state) {},
    );
  }
}
