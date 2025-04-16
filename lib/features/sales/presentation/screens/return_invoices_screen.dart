import 'package:flutter/material.dart';
import 'package:market/features/sales/data/models/sale_model.dart';
import 'package:market/features/sales/presentation/screens/day_invoices.dart';

class ReturnInvoicesScreen extends StatelessWidget {
  const ReturnInvoicesScreen(
      {super.key, required this.invoices, });

  final List<InvoiceModel> invoices;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading:
            IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon:const Icon(Icons.arrow_back_ios) )
        ),
        body: DayInvoices(
          isToday: false,
          returnInvoices: true,
          invoices: invoices,
        ),
      ),
    );
  }
}
