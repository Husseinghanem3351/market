import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/sales/presentation/cubit/states.dart';
import 'package:market/features/sales/presentation/screens/sales.dart';

import '../cubit/cubit.dart';

class SearchProductsWidget extends StatelessWidget {
  const SearchProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesCubit, SalesStates>(
      builder: (BuildContext context, SalesStates state) {
        return Expanded(
          child: GridView.count(
            crossAxisCount: 10,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 1,
            children: List.generate(
              SalesCubit.get(context).productsByName?.length ?? 0,
              (index) => InkWell(
                onTap: () {
                  SalesCubit.get(context).searchProduct(
                    SalesCubit.get(context).productsByName![index].id,);
                  SalesScreen.focusNode.requestFocus();
                },
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                        SalesCubit.get(context).productsByName![index].name),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
