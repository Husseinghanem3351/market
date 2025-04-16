import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/products/presentation/cubit/cubit.dart';
import 'package:market/features/products/presentation/cubit/states.dart';
import 'package:market/features/products/presentation/widgets/product_widget.dart';
import 'package:market/global/widgets/default_button.dart';

import '../../../../global/widgets/default_text_form_field.dart';

class ChooseCategoryProducts extends StatelessWidget {
  const ChooseCategoryProducts({super.key, required this.catId});

  final int catId;
  static TextEditingController searchController = TextEditingController();
  static final ScrollController _myController1 =
      ScrollController(); // make seperate controllers
  static final ScrollController _myController2 = ScrollController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return BlocConsumer<ProductsCubit, ProductsStates>(
      listener: (context, state) {},
      builder: (context, state) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                ProductsCubit.get(context).getProducts;
                searchController.clear();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
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
              )
            ],
          ),
          body: Row(
            children: [
              if (ProductsCubit.get(context).categoryProducts!.isNotEmpty)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      controller: _myController1,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: ProductWidget(
                                productModel: ProductsCubit.get(context)
                                    .categoryProducts![index],
                              ),
                            ),
                            Checkbox(
                              onChanged: (value) {
                                ProductsCubit.get(context)
                                    .addOrRemoveProduct(false, index);
                              },
                              value: true,
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        height: 30,
                        color: Colors.grey,
                      ),
                      itemCount:
                          ProductsCubit.get(context).categoryProducts?.length ??
                              0,
                    ),
                  ),
                ),
              Expanded(
                child: ListView.separated(
                  controller: _myController2,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: ProductWidget(
                            productModel:
                                ProductsCubit.get(context).products![index],
                          ),
                        ),
                        Checkbox(
                          onChanged: (value) {
                            ProductsCubit.get(context)
                                .addOrRemoveProduct(true, index);
                          },
                          value: false,
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    height: 30,
                    color: Colors.grey,
                  ),
                  itemCount: ProductsCubit.get(context).products?.length ?? 0,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: DefaultButton(
                    color: Colors.green.withOpacity(.2),
                    onPressed: () {
                      ProductsCubit.get(context).addProductsToCat(catId);
                      Navigator.pop(context);
                    },
                    textBtn: 'اضافة',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
