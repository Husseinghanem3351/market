import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/purchase/data/models/purchase_model.dart';
import 'package:market/features/purchase/presentation/cubit/cubit.dart';
import 'package:market/features/purchase/presentation/cubit/states.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({
    super.key,
  });

  static List<PurchaseModel> purchases = [];

  @override
  Widget build(BuildContext context) {
    purchases = PurchasesCubit.get(context).purchases;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<PurchasesCubit, PurchaseStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('عمليات الشراء'),
          ),
          body: ListView.separated(
            itemBuilder: (context, index) {
              double price=(purchases[index].buyingPrice * purchases[index].quantity).roundToDouble();
              price-=price%500;
              return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(.3),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Text(purchases[index].dateAndTime.substring(0,16)),
                    Row(
                      children: [
                        const Text('الاسم'),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(purchases[index].productName),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('الكمية'),
                        const SizedBox(
                          width: 50,
                        ),
                        Text('${purchases[index].quantity}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('السعر'),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                            '$price'),
                      ],
                    ),
                  ],
                ),
              ),
            );
            },
            separatorBuilder: (context, index) => Container(
              height: 1,
              width: double.infinity,
              color: Colors.black12,
            ),
            itemCount: purchases.length,
          ),
        ),
      ),
    );
  }
}
