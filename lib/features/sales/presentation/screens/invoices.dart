import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/sales/presentation/cubit/cubit.dart';
import 'package:market/features/sales/presentation/cubit/states.dart';
import 'package:market/features/sales/presentation/screens/day_invoices.dart';
import 'package:market/features/sales/presentation/screens/return_invoices_screen.dart';
import 'package:market/features/sales/presentation/widgets/day_invoices_widget.dart';
import 'package:market/global/global_methods.dart';

class Invoices extends StatelessWidget {
  const Invoices({super.key});

  static double total = 0;

  static double reward = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesCubit, SalesStates>(
        listener: (context, state) {},
        builder: (context, state) => BlocConsumer<SalesCubit, SalesStates>(
              listener: (context, state) {},
              builder: (context, state) => Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                        onPressed: () {
                          total = 0;
                          reward = 0;
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          navigateTo(
                            context,
                            ReturnInvoicesScreen(
                              invoices: SalesCubit.get(context).returnInvoices,
                            ),
                          );
                        },
                        child: const Text(
                          'الفواتير المرتجعة',
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            getExcelData(context);
                          },
                          child: const Text('استيراد من ملف اكسل')),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(.4),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('اجمالي مبيعات اليوم: '),
                              Text('$total'),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(.4),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('اجمالي الارباح: '),
                              Text('$reward'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: Column(
                    children: [
                      TextButton(
                        child: !SalesCubit.get(context).showWayInvoices
                            ? const Text('عرض الكل')
                            : const Text('عرض مبيعات اليوم'),
                        onPressed: () {
                          SalesCubit.get(context).showAllInvoices();
                        },
                      ),
                      if (!SalesCubit.get(context).showWayInvoices)
                        Expanded(
                          child: DayInvoices(
                            isToday: true,
                            returnInvoices: false,
                            invoices: SalesCubit.get(context).todayInvoices,
                          ),
                        ),
                      if (SalesCubit.get(context).showWayInvoices)
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                              height: 20,
                              color: Colors.green.withOpacity(.2),
                            ),
                            itemCount: SalesCubit.get(context).dates.length,
                            itemBuilder: (context, index) => DayInvoicesWidget(
                              date: SalesCubit.get(context).dates[index],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ));
  }
}
