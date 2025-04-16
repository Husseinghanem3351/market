import 'package:market/features/payment/data/models/payment_model.dart';
import 'package:market/features/payment/domain/repositories/payments_repositories.dart';

class AddPaymentsUseCase{
  late final  PaymentRepositories repositories;

  AddPaymentsUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<void> call(PaymentModel payment) async{
    return await repositories.addPayment(payment);
  }
}