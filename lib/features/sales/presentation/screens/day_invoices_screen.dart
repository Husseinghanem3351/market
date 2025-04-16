import 'package:flutter/material.dart';
import 'package:market/features/sales/data/models/sale_model.dart';
import 'package:market/features/sales/presentation/screens/day_invoices.dart';

class DayInvoicesScreen extends StatelessWidget {
  const DayInvoicesScreen(
      {super.key, required this.invoices, required this.dateDay});

  final List<InvoiceModel> invoices;
  final String dateDay;
  static double reward = 0;
  static double total = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            actions: [
              const Text('الاجمالي: '),
              Text('$total'),
              const Text('الربح: '),
              Text('$reward'),
            ],
            title: Text(
              dateDay,
            ),
            leading: IconButton(
                onPressed: () {
                  total = 0;
                  reward = 0;
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios))),
        body: DayInvoices(
          isToday: false,
          returnInvoices: false,
          invoices: invoices,
        ),
      ),
    );
  }
}
