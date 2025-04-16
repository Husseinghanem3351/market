// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
//
// late final Database database;
//
// Future<void> createDatabase() async {
//   try {
//     database = await openDatabase(
//       'green market.db',
//       version: 1,
//       onConfigure: (database) {},
//       onCreate: (
//         database,
//         version,
//       ) {
//         database.execute(
//           'create table if not exists users('
//           'id integer primary key,'
//           'userName text unique,'
//           'password text,'
//           'type text'
//           ')',
//         );
//         database.execute(
//           'create table if not exists purchaseNew('
//           'id integer primary key,'
//           'productName text,'
//           'productId integer,'
//           'quantity double,'
//           'dateAndTime text,'
//           'sellingPrice double,'
//           'buyingPrice double,'
//           'packageQuantity integer,'
//           'userName text'
//           ')',
//         );
//         // await database.execute('drop table if exists salesNew');
//         database.execute(
//           'create table if not exists productsNew('
//           'id text primary key,'
//           'name text unique,'
//           'quantity double,'
//           'sellingPrice double,'
//           'buyingPrice double,'
//           'packageQuantity integer'
//           ')',
//         );
//
//         database.execute(
//           'create table if not exists salesNew('
//           'id integer primary key,'
//           'productName text,'
//           'productId text,'
//           'quantity double,'
//           'price double,'
//           'saleInvoice int,'
//           'userName text, '
//           'customerName text,'
//           'customerId integer'
//           ')',
//         );
//         database.execute(
//           'create table if not exists payments('
//           'id integer primary key,'
//           'description text,'
//           'amount double,'
//           'userName text,'
//           'dateAndTime text'
//           ')',
//         );
//         database.execute(
//           'create table if not exists employers('
//           'id integer primary key,'
//           'userName text unique,'
//           'name text ,'
//           'password text,'
//           'position text,'
//           'salary double,'
//           'goalAmount double'
//           ')',
//         );
//         database.execute(
//           'create table if not exists sessions('
//           'id integer primary key,'
//           'userName text,'
//           'dateAndTime text,'
//           'sellingAmount double,'
//           'buyingAmount double'
//           ')',
//         );
//
//         database.execute(
//           'create table if not exists rewards('
//           'id integer primary key,'
//           'userName text,'
//           'dateAndTime text,'
//           'description text'
//           ')',
//         );
//         database.execute(
//           'create table if not exists customers('
//           'id integer primary key,'
//           'deptAmount double,'
//           'priceSelling text,'
//           'name text'
//           ')',
//         );
//         database.execute(
//           'create table if not exists salesInvoicesNew('
//           'id integer primary key,'
//           'dateAndTime text,'
//           'userName text, '
//           'customerName text,'
//           'price double,'
//           'customerId integer,'
//           'discount double'
//           ')',
//         );
//          database.transaction(
//               (txn) => txn.insert(
//             'employers',
//                 {
//                   'username':'mainUser',
//                   'password':'Hmkc2020hmkC',
//                   'name':'admin',
//                   'salary':100000,
//                   'goalAmount':500000,
//                   'position':'admin',
//                 },
//           ),
//         );
//       },
//       onOpen: (database) async {
//         database.execute(
//           'create table if not exists users('
//           'id integer primary key,'
//           'userName text unique,'
//           'password text,'
//           'type text'
//           ')',
//         );
//         database.execute(
//           'create table if not exists salesInvoicesNew('
//           'id integer primary key,'
//           'dateAndTime text,'
//           'userName text, '
//           'customerName text,'
//           'price double,'
//           'customerId integer,'
//           'discount double'
//           ')',
//         );
//         // database.execute('drop table if exists purchaseNew ');
//         database.execute(
//           'create table if not exists purchaseNew('
//           'id integer primary key,'
//           'productName text,'
//           'productId text,'
//           'quantity double,'
//           'dateAndTime text,'
//           'sellingPrice double,'
//           'buyingPrice double,'
//           'packageQuantity integer,'
//           'userName text'
//           ')',
//         );
//         // await database.execute('drop table if exists salesNew');
//         database.execute(
//           'create table if not exists productsNew('
//           'id text primary key,'
//           'name text unique,'
//           'quantity double,'
//           'sellingPrice double,'
//           'buyingPrice double,'
//           'packageQuantity integer,'
//           'categoryId integer,'
//           'packagePrice double,'
//           'dollarPrice double'
//           ')',
//         );
//         database.execute(
//           'create table if not exists productsBarcodes('
//               'id text primary key,'
//               'productId text Unique'
//               ')',
//         );
//
//         database.execute(
//           'create table if not exists salesNew('
//           'id integer primary key,'
//           'productName text,'
//           'productId text,'
//           'quantity double,'
//           'price double,'
//           'saleInvoice int,'
//           'userName text, '
//           'customerName text,'
//           'customerId integer'
//           ')',
//         );
//
//         database.execute(
//           'create table if not exists returnSalesInvoice('
//               'id integer primary key,'
//               'dateAndTime text,'
//               'userName text, '
//               'customerName text,'
//               'price double,'
//               'customerId integer,'
//               'discount double'
//               ')',
//         );
//         database.execute(
//           'create table if not exists returnSales('
//               'id integer primary key,'
//               'productName text,'
//               'productId text,'
//               'quantity double,'
//               'price double,'
//               'saleInvoice int,'
//               'userName text, '
//               'customerName text,'
//               'customerId integer'
//               ')',
//         );
//         database.execute(
//           'create table if not exists categories('
//           'id integer primary key,'
//           'categoryName text'
//           ')',
//         );
//
//         // database.execute('ALTER TABLE productsNew '
//         //     'ADD packagePrice double');
//
//         //
//         // database.execute('delete from salesInvoices where id>0');
//         // database.execute('delete from purchase where id>0');
//         // database.execute('delete from sales where id>0');
//         // database.execute('drop table if exists products');
//         // database.execute('drop table if exists sales');
//         // database.execute('drop table if exists purchase');
//         // database.execute('drop table if exists productIds');
//         //
//         // database.execute(
//         //   'create table if not exists products('
//         //   'id text primary key,'
//         //   'name text unique,'
//         //   'quantity integer,'
//         //   'sellingPrice double,'
//         //   'buyingPrice double,'
//         //   'packageQuantity integer'
//         //   ')',
//         // );
//         //
//         // database.execute(
//         //   'create table if not exists sales('
//         //       'id integer primary key,'
//         //       'productName text,'
//         //       'productId text,'
//         //       'quantity integer,'
//         //       'price double,'
//         //       'saleInvoice int,'
//         //       'userName text, '
//         //       'customerName text,'
//         //       'customerId integer'
//         //       ')',
//         // );
//         //
//         // database.execute(
//         //   'create table if not exists purchase('
//         //       'id integer primary key,'
//         //       'productName text,'
//         //       'productId integer,'
//         //       'quantity integer,'
//         //       'dateAndTime text,'
//         //       'sellingPrice double,'
//         //       'buyingPrice double,'
//         //       'packageQuantity integer,'
//         //       'userName text'
//         //       ')',
//         // );
//       },
//     );
//   } catch (error) {
//     print(error);
//   }
// }
// //
// Future<void> getData ()async{
//   final value=await database.rawQuery('select * from productsNew');
//   value.forEach((element) {
//     database.insert('productsBarcodes', {
//       'productId':element['id'],
//       'id':element['id'],
//     });
//   },);
// }
//