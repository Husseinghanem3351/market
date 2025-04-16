import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/sales/presentation/widgets/sale_widget.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';

class SalesItemsWidget extends StatelessWidget {
  const SalesItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesCubit, SalesStates>(
      listener: (context, state) {},
      builder: (context, state) => Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return SaleWidget(
                saleModel: SalesCubit.get(context).sales[index],
                index: index,
                quantity: SalesCubit.get(context).quantities[index],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: SalesCubit.get(context).sales.length,
          ),
        ),
      ),
    );
  }
}
