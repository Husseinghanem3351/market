import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/products/presentation/cubit/cubit.dart';
import 'package:market/features/products/presentation/cubit/states.dart';
import 'package:market/features/products/presentation/widgets/category_widget.dart';
import 'package:market/global/global_methods.dart';

import '../../domain/entities/category.dart';
import 'add_new_category.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.categories,
  });

  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<ProductsCubit, ProductsStates>(
        listener: (context, state) {},
        builder: (context, state) =>
            BlocConsumer<ProductsCubit, ProductsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  TextButton(
                    onPressed: () {
                      navigateTo(context, const AddNewCategory());
                    },
                    child: const Text(
                      "اضافة صنف",
                    ),
                  ),
                ],
              ),
              body: ListView.separated(
                itemBuilder: (context, index) => CategoryWidget(
                  category: categories[index],
                ),
                separatorBuilder: (context, index) => Divider(
                  height: 20,
                  color: Colors.green.withOpacity(.2),
                ),
                itemCount: categories.length,
              ),
            );
          },
        ),
      ),
    );
  }
}
