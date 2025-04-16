import 'package:flutter/material.dart';
import 'package:market/features/sales/presentation/screens/sales.dart';

class RowDescribeInvoiceWidget extends StatelessWidget {
  const RowDescribeInvoiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = SalesScreen.size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: width / 10,
        ),
        SizedBox(
          width: width / 10,
        ),
        SizedBox(
          width: width / 10,
          child: const Text(
            'المنتج',
          ),
        ),
        SizedBox(
          width: width / 10,
          child: const Text(
            'الكمية',
          ),
        ),
        SizedBox(
          width: width / 10,
          child: const Text(
            'السعر',
          ),
        ),
        SizedBox(
          width: width / 10,
          child: const Text(
            'الكمية الموجودة',
          ),
        ),
      ],
    );
  }
}
