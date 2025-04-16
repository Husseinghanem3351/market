import 'package:market/features/customers/data/data_sources/customers_local_data_source.dart';
import 'package:market/features/customers/data/models/customer_model.dart';
import 'package:market/features/customers/domain/repositories/customers_repositories.dart';

class CustomersRepositoriesImplementation implements CustomersRepositories {
  final CustomersLocalDataSource customersLocalDataSource =
      CustomersLocalDataSourceImplementation();

  @override
  Future<void> addCustomer(CustomerModel customerModel) async {
    await customersLocalDataSource.addCustomer(customerModel);
  }

  @override
  Future<void> deleteCustomer(int id) async {
    await customersLocalDataSource.deleteCustomer(id);
  }

  @override
  Future<List<CustomerModel>?> getCustomers() async {
    return await customersLocalDataSource.getCustomers();
  }

  @override
  Future<void> updateCustomer(CustomerModel customerModel) async {
    await customersLocalDataSource.updateCustomer(customerModel);
  }
}
