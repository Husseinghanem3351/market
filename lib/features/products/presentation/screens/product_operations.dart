import 'package:flutter/material.dart';

import '../../data/models/product_operation_model.dart';

class ProductOperations extends StatelessWidget {
  const ProductOperations({
    super.key,
    required this.productsOperation,
  });

  final List<ProductOperationModel> productsOperation;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: ListView.separated(
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(10),
                  color: productsOperation[index].operationType == 'sell'
                      ? Colors.blueGrey.withOpacity(.3)
                      : Colors.white,
                  child: Column(
                    children: [
                      Text(productsOperation[index].operationType != 'sell'
                          ? 'شراء'
                          : 'بيع'),
                      if (productsOperation[index].date != null)
                        Row(
                          children: [
                            const Text('التاريخ'),
                            const SizedBox(width: 50,),
                            Text(productsOperation[index].date!),
                          ],
                        ),
                      Row(
                        children: [
                          const Text('الكمية'),
                          const SizedBox(width: 50,),
                          Text('${productsOperation[index].quantity}'),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('السعر'),
                          const SizedBox(width: 50,),
                          Text('${productsOperation[index].price}'),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('الاسم'),
                          const SizedBox(width: 50,),
                          Text(productsOperation[index].name),
                        ],
                      ),
                    ],
                  ),
                ),
            separatorBuilder: (context, index) => Container(
                  height: 5,
                  width: double.infinity,
                  color: Colors.black12,
                ),
            itemCount: productsOperation.length,),
      ),
    );
  }
}
