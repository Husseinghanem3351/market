import 'package:flutter/material.dart';
import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/purchase/presentation/screens/add_purchases_screen.dart';

import '../../../../global/global_methods.dart';

class PurchaseProductWidget extends StatelessWidget {
  const PurchaseProductWidget({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey.withOpacity(.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              AddPurchasesScreen.productIdController.text = productModel.id;
              AddPurchasesScreen.productNameController.text = productModel.name;
              AddPurchasesScreen.dollarPriceController.text = productModel.dollarPrice?.toString()??'';
              AddPurchasesScreen.packageController.text = productModel.packageQuantity?.toString()??'';
              navigateTo(
                context,
                const AddPurchasesScreen(addExistingProduct: true,),
              );
            },
            icon: const Icon(Icons.add,),
          ),
          SizedBox(
            width: width / 2,
            child: Text(productModel.name),
          ),
          SizedBox(
            width: width / 5,
            child: Text('${productModel.sellingPrice}'),
          ),
          SizedBox(
            width: width / 5,
            child: Text('${productModel.buyingPrice}'),
          ),
          const Spacer(),
          Text('${productModel.quantity}'),
        ],
      ),
    );
  }
}
