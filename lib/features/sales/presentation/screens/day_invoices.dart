import 'package:flutter/material.dart';
import '../../data/models/sale_model.dart';
import '../widgets/invoice_widget.dart';

class DayInvoices extends StatelessWidget {
  const DayInvoices({super.key, required this.invoices, required this.returnInvoices, required this.isToday,});

  final List<InvoiceModel> invoices;
  final bool returnInvoices;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        height: 20,
        color: Colors.green.withOpacity(.2),
      ),
      itemCount: invoices.length,
      itemBuilder: (context, index) => InvoiceWidget(
        isToday: isToday,
        returnInvoices: returnInvoices,
        invoiceModel: invoices[index],
      ),
    );
  }
}
