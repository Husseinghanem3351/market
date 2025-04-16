import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/sales/data/models/sale_model.dart';
import 'package:market/features/sales/presentation/cubit/cubit.dart';
import 'package:market/features/sales/presentation/cubit/states.dart';
import 'package:market/features/sales/presentation/screens/sales.dart';

class SaleWidget extends StatelessWidget {
  const SaleWidget({
    super.key,
    required this.saleModel,
    required this.index,
    required this.quantity,
  });

  final SaleModel saleModel;
  final int index;
  final double quantity;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .sizeOf(context)
        .width;
    TextEditingController quantityController = TextEditingController(
      text: saleModel.quantity.toString(),
    );
    TextEditingController priceController = TextEditingController(
      text: saleModel.price.toString(),
    );
    double piecePrice = saleModel.price / saleModel.quantity;
    return BlocConsumer<SalesCubit, SalesStates>(
      builder: (BuildContext context, SalesStates state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(.1),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  IconButton(
                  onPressed: () {
          SalesCubit.get(context).removeItem(
          index,
          double.parse(
          priceController.text,
          ),
          );
          SalesScreen.focusNode.requestFocus();
          },
              icon: const Icon(Icons.delete)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  SalesCubit.get(context).sellPackageItem(index);
                },
                child: const Text('طرد',),),
                IconButton(
                  onPressed: () {
                    SalesCubit.get(context).changeQuantity(index, '+');

                    SalesScreen.focusNode.requestFocus();
                  },
                  icon: const Icon(Icons.add),
                  iconSize: 15,
                ),
                IconButton(
                  onPressed: () {
                    SalesCubit.get(context).changeQuantity(index, '-');
                    SalesScreen.focusNode.requestFocus();
                  },
                  icon: const Icon(Icons.minimize),
                  iconSize: 15,
                ),
                ],
              ),
              SizedBox(
                width: 100,
                child: Text(
                  saleModel.productName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: width / 9,
                  child: TextFormField(
                    controller: quantityController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      double quantity = double.tryParse(value) ?? 0;
                      priceController.text =
                          (quantity * piecePrice).toString();
                      SalesScreen.price -= saleModel.price;
                      saleModel.price = piecePrice * quantity;
                      saleModel.quantity = quantity;
                      SalesScreen.price += saleModel.price;
                      // SalesCubit.get(context).makeDiscount();
                    },
                    onFieldSubmitted: (value) {
                      SalesCubit.get(context).makeDiscount();

                      SalesScreen.focusNode.requestFocus();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: width / 9,
                  child: TextFormField(
                    controller: priceController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      double price = value.isEmpty ? 0 : double.parse(value);
                      quantityController.text =
                          (price / piecePrice).toString();
                      SalesScreen.price -= saleModel.price;
                      saleModel.price = price;
                      saleModel.quantity = price / piecePrice;
                      SalesScreen.price += saleModel.price;
                    },
                    onFieldSubmitted: (value) {
                      SalesCubit.get(context).makeDiscount();

                      SalesScreen.focusNode.requestFocus();
                    },
                  ),
                ),
              ),
              Text(
                '$quantity',
              ),
            ],
          ),
        ),);
      },
      listener: (context, state) {},
    );
  }
}
