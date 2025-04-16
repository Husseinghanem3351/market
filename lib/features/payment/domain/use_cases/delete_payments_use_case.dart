import 'package:market/features/payment/domain/repositories/payments_repositories.dart';

class DeletePaymentsUseCase{
  late final  PaymentRepositories repositories;

  DeletePaymentsUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(int id) async{
    return await repositories.deletePayment(id);
  }
}