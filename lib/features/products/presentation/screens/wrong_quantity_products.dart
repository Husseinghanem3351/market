import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/products/presentation/cubit/cubit.dart';
import 'package:market/features/products/presentation/cubit/states.dart';

import '../widgets/product_widget.dart';

class WrongQuantityProducts extends StatelessWidget {
  const WrongQuantityProducts({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<ProductsCubit,ProductsStates>(
        builder:(context, state) =>  Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: width / 2, child: const Text('المنتج')),
                    SizedBox(width: width / 5, child: const Text('سعر البيع')),
                    SizedBox(width: width / 5, child: const Text('سعر الشراء')),
                    const Spacer(),
                    const Text('الكمية'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => ProductWidget(
                        productModel:
                        ProductsCubit.get(context).wrongQuantityProducts![index]),
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.withOpacity(.2),
                    ),
                    itemCount: ProductsCubit.get(context).wrongQuantityProducts?.length??0,
                  ),
                ),
              ],
            ),
          ),
        ),
        listener:(context, state) {

        } ,
      ),
    );
  }
}
