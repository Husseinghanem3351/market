import 'package:market/features/customers/data/models/customer_model.dart';
import 'package:market/features/customers/domain/repositories/customers_repositories.dart';

class GetCustomersUseCase{
  late final  CustomersRepositories repositories;

  GetCustomersUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<List<CustomerModel>?> call() async{
    return await repositories.getCustomers();
  }
}