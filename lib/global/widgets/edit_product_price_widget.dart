import 'package:flutter/material.dart';
import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/global/widgets/default_text_form_field.dart';

class EditProductPriceWidget extends StatelessWidget {
  const EditProductPriceWidget({super.key, required this.productModel, });

  final ProductModel productModel;
  static TextEditingController newPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    newPriceController.text = productModel.sellingPrice.toString();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(.4),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(productModel.name),
            Text('${productModel.buyingPrice}',),
            SizedBox(
              width: 200,
              child: DefaultFormField(
                controller: newPriceController,
                onChanged: (p0) {
                  productModel.buyingPrice = double.parse(
                    newPriceController.text,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
