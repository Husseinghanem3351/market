import 'package:flutter/material.dart';
import 'package:market/features/products/data/models/product_model.dart';
import 'package:market/features/products/presentation/cubit/cubit.dart';
import 'package:market/features/products/presentation/widgets/product_widget.dart';
import 'package:market/global/widgets/default_button.dart';

class CatProducts extends StatelessWidget {
  const CatProducts({super.key, required this.products, required this.catId});

  final List<ProductModel> products;
  final int catId;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            DefaultButton(
              onPressed: () {
                ProductsCubit.get(context).navigateToChooseProducts(context, catId);
              },
              textBtn: 'اضافة منتجات جديدة',
            )
          ],
        ),
        body: ListView.separated(
          itemBuilder: (context, index) => ProductWidget(
            productModel: products[index],
          ),
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey.withOpacity(.1),
          ),
          itemCount: products.length,
        ),
      ),
    );
  }
}
