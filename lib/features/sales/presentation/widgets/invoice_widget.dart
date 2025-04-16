import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/sales/data/models/sale_model.dart';
import 'package:market/features/sales/presentation/cubit/cubit.dart';
import 'package:market/features/sales/presentation/cubit/states.dart';

class InvoiceWidget extends StatelessWidget {
  const InvoiceWidget({
    super.key,
    required this.invoiceModel,
    required this.returnInvoices, required this.isToday,
  });

  final InvoiceModel invoiceModel;

  final bool returnInvoices;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return BlocConsumer<SalesCubit, SalesStates>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Text(invoiceModel.dateAndTime.substring(0,16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: width / 4.5, child: const Text('الاسم')),
                  SizedBox(width: width / 4.5, child: const Text('الكمية')),
                  SizedBox(width: width / 4.5, child: const Text('السعر')),
                  if (invoiceModel.customerName != null)
                    SizedBox(
                      width: width / 4.5,
                      child: const Text(
                        'اسم الزبون',
                      ),
                    ),
                  const Spacer(),
                  if(!returnInvoices&&isToday)
                  IconButton(
                    onPressed: () {
                      SalesCubit.get(context).deleteInvoice(
                        invoiceModel.id!,
                        context
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                ],
              ),
              Column(
                children: List<Widget>.generate(
                  invoiceModel.sales?.length ?? 0,
                  (index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: width / 4.5,
                            child:
                                Text(invoiceModel.sales![index].productName)),
                        SizedBox(
                            width: width / 4.5,
                            child:
                                Text('${invoiceModel.sales![index].quantity}')),
                        SizedBox(
                            width: width / 4.5,
                            child: Text('${invoiceModel.sales![index].price}')),
                        if (invoiceModel.customerName != null)
                          SizedBox(
                              width: width / 4.5,
                              child: Text('${invoiceModel.customerName}')),
                        const Spacer(),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('الاجمالي'),
                  Text(
                    '${invoiceModel.price}',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('الحسم'),
                  Text(
                    '${invoiceModel.discount}',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      listener: (context, state) {},
    );
  }
}
