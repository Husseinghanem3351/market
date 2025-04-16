import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/products/presentation/cubit/cubit.dart';
import 'package:market/features/products/presentation/cubit/states.dart';
import 'package:market/features/purchase/presentation/widgets/purchase_product_widget.dart';
import 'package:market/global/widgets/default_text_form_field.dart';

class AddExistingProduct extends StatelessWidget {
  const AddExistingProduct({super.key});

  static TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<ProductsCubit, ProductsStates>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            actions: [
              SizedBox(
                width: width / 3,
                child: DefaultFormField(
                  controller: searchController,
                  labelText: 'بحث',
                  onChanged: (p0) {
                    ProductsCubit.get(context)
                        .searchProductByName(searchController.text);
                  },
                ),
              ),
            ],
            title: const Text('اضافة منتج موجود'),
          ),
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
                    itemBuilder: (context, index) => PurchaseProductWidget(
                      productModel: ProductsCubit.get(context).products![index],
                    ),
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.withOpacity(.2),
                    ),
                    itemCount: ProductsCubit.get(context).products?.length ?? 0,
                  ),
                ),
              ],
            ),
          ),
        ),
        listener: (context, state) {},
      ),
    );
  }
}
