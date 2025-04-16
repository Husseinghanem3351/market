import 'package:market/features/customers/domain/repositories/customers_repositories.dart';

class DeleteCustomerUseCase{
  late final  CustomersRepositories repositories;

  DeleteCustomerUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(int id) async{
    return await repositories.deleteCustomer(id);
  }
}