import 'package:flutter/material.dart';
import 'package:market/features/employers/presentation/cubit/cubit.dart';
import 'package:market/features/employers/presentation/screens/users_screen.dart';
import 'package:market/features/products/presentation/cubit/cubit.dart';
import 'package:market/features/products/presentation/screens/products.dart';
import 'package:market/features/purchase/presentation/cubit/cubit.dart';
import 'package:market/features/sales/presentation/cubit/cubit.dart';
import 'package:market/global/edit_dollar_price.dart';
import 'package:market/global/global_methods.dart';
import 'package:market/global/widgets/default_button.dart';

import '../features/sales/presentation/screens/invoices.dart';

class ToInfoScreen extends StatelessWidget {
  const ToInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Align(
          alignment: Alignment.topRight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultButton(
                  color: Colors.green,
                  onPressed: () {
                    SalesCubit.get(context).getInvoices();
                    SalesCubit.get(context).getReturnInvoices();
                    navigateTo(context, const Invoices());
                  },
                  textBtn: 'الفواتير',
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: DefaultButton(
              //     onPressed: () {},
              //     textBtn: 'customers',
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultButton(
                  color: Colors.green,
                  onPressed: () {
                    ProductsCubit.get(context).getProducts();
                    navigateTo(context, const Products());
                  },
                  textBtn: 'المنتجات',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultButton(
                  color: Colors.green,
                  onPressed: () {
                    PurchasesCubit.get(context).navigateToPurchases(context);
                  },
                  textBtn: 'المشتريات',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultButton(
                  color: Colors.green,
                  onPressed: () {},
                  textBtn: 'الارياح',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultButton(
                  color: Colors.green,
                  onPressed: () {
                    EmployersCubit.get(context).getUsers();
                    navigateTo(
                      context,
                      const UsersScreen(),
                    );
                  },
                  textBtn: 'المستخدمين',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultButton(
                  color: Colors.green,
                  onPressed: () {
                    ProductsCubit.get(context).getProducts();
                    navigateTo(
                      context,
                      const EditDollarPrice(),
                    );
                  },
                  textBtn: 'تعديل الاسعار حسب الدولار',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
