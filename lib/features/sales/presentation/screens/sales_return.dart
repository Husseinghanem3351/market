import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/features/sales/presentation/cubit/cubit.dart';
import 'package:market/features/sales/presentation/cubit/states.dart';
import 'package:market/features/sales/presentation/widgets/invoice_information_widget.dart';
import 'package:market/features/sales/presentation/widgets/row_describe_invoice_widget.dart';
import 'package:market/features/sales/presentation/widgets/sales_items_widget.dart';
import 'package:market/features/sales/presentation/widgets/save_invoice_button.dart';
import 'package:market/features/sales/presentation/widgets/search_by_name_widget.dart';
import 'package:market/features/sales/presentation/widgets/search_widget.dart';
import '../widgets/search_products_widget.dart';

class SalesReturn extends StatelessWidget {
  const SalesReturn({super.key});

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
          SalesReturn.discountController.clear();
          SalesReturn.focusNode.requestFocus();
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<SalesCubit, SalesStates>(
          listener: (context, state) {},
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  SalesCubit.get(context).sales.clear();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              actions: const [
                SearchByNameWidget(),
                SearchWidget(),
              ],
              title: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Text(
                  'نقطة مرتجع',
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
                            ...[
                              SalesItemsWidget(),
                            ],
                            SearchProductsWidget(),
                            SaveInvoiceButton(
                              isReturn: true,
                            ),
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
