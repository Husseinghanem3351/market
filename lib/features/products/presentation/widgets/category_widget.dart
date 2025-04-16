import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/products/presentation/cubit/cubit.dart';
import 'package:market/features/products/presentation/cubit/states.dart';
import '../../../../global/global_methods.dart';
import '../../domain/entities/category.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.category});

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsStates>(
      builder: (BuildContext context, ProductsStates state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withOpacity(.1),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    editCategoryDialog(
                      context,
                      category.id,
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ProductsCubit.get(context)
                        .navigateToCategoryProducts(category.id, context);
                  },
                  child: Text(
                    '${category.name} ',
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    bool? insuring = await insureDialog(
                      context,
                      'هل انت متاكد تريد حذف هذا الصنف',
                    );
                    if(insuring==true){
                      ProductsCubit.get(context).deleteCategory(category.id, context);
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, ProductsStates state) {},
    );
  }
}
