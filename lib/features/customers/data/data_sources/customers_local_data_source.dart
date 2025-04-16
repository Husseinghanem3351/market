import 'package:market/global/database.dart';
import '../models/customer_model.dart';

abstract class CustomersLocalDataSource {
  Future<void> addCustomer(CustomerModel customer);

  Future<void> deleteCustomer(int id);

  Future<void> updateCustomer(CustomerModel customer);

  Future<List<CustomerModel>?> getCustomers();
}

class CustomersLocalDataSourceImplementation
    implements CustomersLocalDataSource {
  @override
  Future<void> addCustomer(CustomerModel customer) async {
    try {
      await database.transaction(
        (txn) => txn.insert(
          'customers',
          customer.toJson(),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> deleteCustomer(int id) async {
    try {
      await database.rawDelete('delete from customers where id=$id');
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<List<CustomerModel>?> getCustomers() async {
    try {
      final value = await database.rawQuery('select * from customers');
      return value
          .map<CustomerModel>((e) => CustomerModel.fromJson(e))
          .toList();
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Future<void> updateCustomer(CustomerModel customer) async {
    try {
      await database.rawUpdate('update customers set '
          'priceSelling="${customer.priceSelling}",'
          'name="${customer.name}",'
          'deptAmount=${customer.deptAmount},'
          'where id=${customer.id}');
    } catch (error) {
      print(error);
    }
  }
}
