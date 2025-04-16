import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:market/features/products/domain/entities/category.dart';
import 'package:market/features/products/presentation/cubit/cubit.dart';
import 'package:market/features/purchase/data/models/purchase_model.dart';
import 'package:market/features/purchase/presentation/cubit/cubit.dart';
import 'package:market/global/global.dart';
import 'package:market/global/widgets/default_button.dart';
import 'package:market/global/widgets/default_text_form_field.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'database.dart';

void navigateTo(BuildContext context, Widget screen) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ));
}

void navigateAndFinish(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => false);
}

Future<void> getExcelData(context) async {
  FilePickerResult? pickedFile = await pickFile();
  if (pickedFile != null &&
      await insureDialog(context, 'هل تريد اضافة المنتجات من هذا الملف؟') ==
          true) {
    var bytes = File(pickedFile.files.single.path!).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes.toList());
    for (var table in excel.tables.keys) {
      for (int i = 1; i < excel.tables[table]!.rows.length; i++) {
        var row = excel.tables[table]!.rows[i];

        PurchaseModel purchaseModel = PurchaseModel(
            productId: row[0]!.value!.toString(),
            quantity: 5,
            buyingPrice: double.parse(row[3]!.value!.toString()),
            sellingPrice: double.parse(row[2]!.value!.toString()),
            productName: row[1]!.value!.toString(),
            userName: 'hussein',
            dateAndTime: DateTime.now().toString());
        PurchasesCubit.get(context).addPurchase(purchaseModel);
      }
    }
  }
}

Future<FilePickerResult?> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  return result;
}

Future<bool?> insureDialog(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Text(
                'هل انت متأكد؟',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
              content: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
              actions: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        child: const Text('إلغاء'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      child: const Text('نعم'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ));
}

Future<void> checkPurchase() async {
  final value = await database
      .rawQuery('select * from purchaseNew where productName like "%متة%"');
  print(value);
}

Future<bool> checkFirstUser() async {
  final value = await database.rawQuery('select * from users');
  if (value.isEmpty) {
    database.insert('users', {
      'userName': 'firstUser',
      'password': '123456789',
      'type': 'admin',
    });
    isAdmin = true;
    return true;
  }
  return false;
}

Future<bool?> editCategoryDialog(context, int id) {
  return showDialog(
      context: context,
      builder: (context) {
        TextEditingController nameCatController = TextEditingController();
        var textKey = GlobalKey<FormState>();
        return Form(
          key: textKey,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: SimpleDialog(
              title: const Text('تعديل اسم الصنف'),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DefaultFormField(
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'this field should not empty';
                      }
                      return null;
                    },
                    controller: nameCatController,
                    labelText: 'الاسم',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultButton(
                        onPressed: () {
                          if (textKey.currentState!.validate()) {
                            ProductsCubit.get(context).editCategory(
                                CategoryEntity(
                                  id: id,
                                  name: nameCatController.text,
                                ),
                                context);
                            Navigator.of(context).pop(true);
                          }
                        },
                        textBtn: 'حفظ',
                      ),
                      DefaultButton(
                        onPressed: () {
                          nameCatController.clear();
                          Navigator.of(context).pop(false);
                        },
                        textBtn: 'الغاء',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}
Future<File?> pickDatabaseFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['db', 'sqlite'],
  );

  if (result != null && result.files.single.path != null) {
    return File(result.files.single.path!);
  }
  return null;
}
Future<void> restoreDatabaseData() async {
  final file=await pickDatabaseFile();
  if(file!=null) {
    database.rawDelete('delete from productsNew');
    database.rawDelete('delete from purchaseNew where id>=0');
    database.rawDelete('delete from salesNew where id>=0');
    database.rawDelete('delete from salesInvoicesNew where id>=0');
    Database oldDatabase = await openDatabase(file.path);
    final products = await oldDatabase.rawQuery('select * from productsNew');
    final invoices =
        await oldDatabase.rawQuery('select * from salesInvoicesNew');
    final sales = await oldDatabase.rawQuery('select * from salesNew');
    final purchases = await oldDatabase.rawQuery('select * from purchaseNew');
    products.forEach(
      (element) async {
        await database.transaction(
          (txn) => txn.insert(
            'productsNew',
            element,
          ),
        );
      },
    );
    invoices.forEach(
      (element) async {
        await database.transaction(
          (txn) => txn.insert(
            'salesInvoicesNew',
            element,
          ),
        );
      },
    );
    sales.forEach(
      (element) async {
        await database.transaction(
          (txn) => txn.insert(
            'salesNew',
            element,
          ),
        );
      },
    );
    purchases.forEach(
      (element) async {
        await database.transaction(
          (txn) => txn.insert(
            'purchaseNew',
            element,
          ),
        );
      },
    );
  }
}
