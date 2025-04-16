import 'package:flutter/material.dart';
import 'package:market/features/sales/presentation/screens/sales.dart';

import '../../../../global/widgets/default_button.dart';
import '../cubit/cubit.dart';

class SaveInvoiceButton extends StatelessWidget {
  const SaveInvoiceButton({super.key, required this.isReturn});

  final bool isReturn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // GridView.count(crossAxisCount: ,),
        DefaultButton(
          color: Colors.white60,
          onPressed: () {
            if (isReturn) {
              SalesCubit.get(context).addReturnInvoice();
            }
            if (!isReturn) {
              SalesCubit.get(context).addInvoice();
            }
            SalesScreen.discountController.clear();
            SalesScreen.focusNode.requestFocus();
          },
          textBtn: 'حفظ الفاتورة',
        ),
      ],
    );
  }
}
