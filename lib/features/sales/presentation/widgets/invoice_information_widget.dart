import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/sales/presentation/screens/sales.dart';

import '../../../../global/widgets/default_text_form_field.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class InvoiceInformationWidget extends StatelessWidget {
  const InvoiceInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesCubit, SalesStates>(
        listener: (context, state) {},
        builder: (context, state) => Expanded(
              flex: 1,
              child: Container(
                color: Colors.green,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),

                    Text(
                      '${SalesCubit.get(context).sales.length} مادة ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Center(
                      child: Text(
                        'الاجمالي: ${SalesScreen.price - SalesScreen.discount}',
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 21),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            'الحسم',
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: DefaultFormField(
                              onChanged: (p0) {
                                SalesScreen.discount =
                                    p0.isEmpty ? 0 : double.parse(p0);
                                SalesCubit.get(context).makeDiscount();
                              },
                              textInputType: TextInputType.number,
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onFieldSubmitted: (p0) {
                                SalesScreen.focusNode.requestFocus();
                              },
                              controller: SalesScreen.discountController,
                              labelText: 'ادخل الحسم',
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
