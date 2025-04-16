import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/purchase/presentation/screens/add_purchases_screen.dart';
import 'package:market/features/sales/presentation/cubit/cubit.dart';
import 'package:market/features/sales/presentation/cubit/states.dart';
import 'package:market/features/sales/presentation/widgets/invoice_information_widget.dart';
import 'package:market/features/sales/presentation/widgets/row_describe_invoice_widget.dart';
import 'package:market/features/sales/presentation/widgets/sales_items_widget.dart';
import 'package:market/features/sales/presentation/widgets/save_invoice_button.dart';
import 'package:market/features/sales/presentation/widgets/search_by_name_widget.dart';
import 'package:market/features/sales/presentation/widgets/search_widget.dart';
import 'package:market/global/global.dart';
import 'package:market/global/global_methods.dart';
import '../widgets/search_products_widget.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  static TextEditingController searchController = TextEditingController();
  static TextEditingController searchByNAmeController = TextEditingController();
  static TextEditingController discountController =
      TextEditingController(text: discount.toString());
  static FocusNode focusNode = FocusNode();
  static double price = 0;
  static double discount = 0;
  static Size size = const Size(0, 0);

  @override
  Widget build(BuildContext context) {
    focusNode.requestFocus();
    size = MediaQuery.of(context).size;
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (value) {
        if (value.logicalKey.keyId == 4294969349) {
          SalesCubit.get(context).addInvoice();
          SalesScreen.discountController.clear();
          SalesScreen.focusNode.requestFocus();
        }
        if (value.logicalKey.keyId == 4294969347) {
          SalesCubit.get(context).printInvoice(price.toString(),context);
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<SalesCubit, SalesStates>(
          listener: (context, state) {},
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: () {
                SalesCubit.get(context).sales.clear();
                  price = 0;
                 discount = 0;
                Navigator.pop(context);
              }, icon:const Icon(Icons.arrow_back,),),
              actions: [
                IconButton(
                  onPressed: () async {
                      String executable = Platform.resolvedExecutable; // Path to the current Flutter app
                      await Process.start(executable,['second',isAdmin?'admin':'user',]);
                  },
                  icon: const Icon(Icons.add),
                ),
                const SearchByNameWidget(),
                const SearchWidget(),
                if (isAdmin)
                  TextButton(
                    onPressed: () {
                      navigateTo(context, const AddPurchasesScreen(addExistingProduct: false,));
                    },
                    child: const Text(
                      'اضافة منتج',
                    ),
                  ),

              ],
              title: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Text(
                  'laith market',
                  style: TextStyle(
                      color: Colors.red.withOpacity(.8), fontSize: 25),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.red.withOpacity(.3),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            RowDescribeInvoiceWidget(),
                            ...[SalesItemsWidget()],
                            SearchProductsWidget(),
                            SaveInvoiceButton(isReturn: false,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const InvoiceInformationWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
