 import 'package:flutter/material.dart';
import 'package:market/features/sales/presentation/screens/sales.dart';

import '../../../../global/widgets/default_text_form_field.dart';
import '../cubit/cubit.dart';

class SearchByNameWidget extends StatelessWidget {
   const SearchByNameWidget({super.key});

   @override
   Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 15.0),
       child: SizedBox(
         width: SalesScreen.size.width / 6,
         child: DefaultFormField(
           controller:SalesScreen. searchByNAmeController,
           onChanged: (name) {
             SalesCubit.get(context).searchByName(name);
           },
           onFieldSubmitted: (p0) {
             SalesScreen.searchByNAmeController.clear();
             SalesScreen.focusNode.requestFocus();
           },
           hintText: 'بحث بالاسم',
         ),
       ),
     );
   }
 }
