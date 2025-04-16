import 'package:flutter/material.dart';
import 'package:market/features/employers/presentation/screens/users_screen.dart';
import 'package:market/features/purchase/presentation/screens/add_purchases_screen.dart';
import 'package:market/features/sales/presentation/screens/sales.dart';
import 'package:market/features/sales/presentation/screens/sales_return.dart';
import 'package:market/global/global.dart';
import 'package:market/global/global_methods.dart';
import 'package:market/global/to_info_screen.dart';
import 'package:market/global/widgets/default_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (isAdmin)
            TextButton(
              onPressed: () {
                navigateTo(context, const ToInfoScreen());
              },
              child: const Text('التفاصيل'),
            ),
          if (isAdmin)
            TextButton(
              onPressed: () {
                navigateTo(context, const UsersScreen());
              },
              child: const Text('المستخدمين'),
            ),
          if (isAdmin)
            TextButton(
              onPressed: () {
                navigateTo(context, const AddPurchasesScreen(addExistingProduct: false,));
              },
              child: const Text('اضافة منتج'),
            ),
          // if (isAdmin)
          //   TextButton(
          //     onPressed: () {
          //       // restoreDatabaseData();
          //     },
          //     child: const Text('استيراد بيانات من قاعدة بيانات'),
          //   ),
        ],
      ),
      body: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultButton(
                  color: Colors.green,
                  onPressed: () {
                    navigateTo(context, const SalesScreen());
                  },
                  textBtn: 'نقطة بيع',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultButton(
                  color: Colors.red,
                  onPressed: () {
                    navigateTo(context, const SalesReturn());
                  },
                  textBtn: 'نقطة مرتجع',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
