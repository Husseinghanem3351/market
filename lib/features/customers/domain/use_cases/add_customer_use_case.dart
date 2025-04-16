import 'package:market/features/customers/data/models/customer_model.dart';
import 'package:market/features/customers/domain/repositories/customers_repositories.dart';

class AddCustomerUseCase{
  late final  CustomersRepositories repositories;

  AddCustomerUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(CustomerModel customer) async{
    return await repositories.addCustomer(customer);
  }
}