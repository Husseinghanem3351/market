import 'package:market/features/customers/data/models/customer_model.dart';

abstract class CustomersRepositories {
  Future<void> deleteCustomer(int id);
  Future<void> addCustomer(CustomerModel customerModel);
  Future<void> updateCustomer(CustomerModel customerModel);
  Future<List<CustomerModel>?> getCustomers();

}