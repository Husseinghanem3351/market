import 'package:market/features/customers/domain/repositories/customers_repositories.dart';

import '../../data/models/customer_model.dart';

class UpdateCustomerUseCAse{
  late final  CustomersRepositories repositories;

  UpdateCustomerUseCAse(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(CustomerModel customer) async{
    return await repositories.updateCustomer(customer);
  }
}