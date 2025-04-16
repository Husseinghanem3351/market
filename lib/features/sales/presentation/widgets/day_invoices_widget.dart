import 'package:flutter/material.dart';
import 'package:market/features/sales/presentation/cubit/cubit.dart';
import 'package:market/features/sales/presentation/screens/day_invoices_screen.dart';
import 'package:market/global/global_methods.dart';

import '../../data/models/sale_model.dart';

class DayInvoicesWidget extends StatelessWidget {
  const DayInvoicesWidget({
    super.key,
    required this.date,
  });

  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.withOpacity(.2),
      height: 80,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                date,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                child: const Text('عرض الكل'),
                onPressed: () async {
                  List<InvoiceModel> invoices =await SalesCubit.get(context)
                      .getDayInvoices(date:date);
                  navigateTo(
                    context,
                    DayInvoicesScreen(
                      invoices: invoices,
                      dateDay: date,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
