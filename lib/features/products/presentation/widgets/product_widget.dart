import 'package:flutter/material.dart';
import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/products/presentation/cubit/cubit.dart';
import 'package:market/features/products/presentation/screens/edit_product.dart';
import 'package:market/global/global_methods.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey.withOpacity(.2),
      ),
      child: InkWell(
        onDoubleTap: () {
          ProductsCubit.get(context).navigateToProductOperation(productModel.id,context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  EditProduct.productIdController.text = productModel.id;
                  EditProduct.productNameController.text = productModel.name;
                  EditProduct.buyingPriceController.text =
                      productModel.buyingPrice.toString();
                  EditProduct.sellingPriceController.text =
                      productModel.sellingPrice.toString();
                  EditProduct.quantityController.text =
                      productModel.quantity.toString();
                  EditProduct.packagePriceController.text=productModel.packagePrice?.toString()??'';
                  EditProduct.dollarPriceController.text=productModel.dollarPrice?.toString()??'';
                  EditProduct.packageController.text=productModel.packageQuantity?.toString()??'';
                  navigateTo(
                    context,
                    EditProduct(
                      productModel: productModel,
                    ),
                  );
                },
                icon: const Icon(Icons.edit)),
            SizedBox(width: 100,child: Text(productModel.name),),
            Text('${productModel.sellingPrice}'),
            Text('${productModel.buyingPrice}'),
            Text('${productModel.quantity}'),
          ],
        ),
      ),
    );
  }
}
