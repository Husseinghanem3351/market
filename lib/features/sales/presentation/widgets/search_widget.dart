import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/sales/presentation/screens/sales.dart';

import '../../../../global/widgets/default_text_form_field.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesCubit, SalesStates>(
      listener: (context, state) {},
     builder: (context, state) =>  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: SalesScreen.size.width / 4,
            child: DefaultFormField(
              focusNode: SalesScreen.focusNode,
              controller: SalesScreen.searchController,
              hintText: 'باركود',
              onFieldSubmitted: (p0) {
                SalesCubit.get(context).searchProduct(p0);
                SalesScreen.focusNode.requestFocus();
              },
            ),
          ),
        ),
    );
  }
}
