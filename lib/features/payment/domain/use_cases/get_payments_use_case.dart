import 'package:market/features/payment/data/models/payment_model.dart';
import 'package:market/features/payment/domain/repositories/payments_repositories.dart';

class GetPaymentsUseCase{
  late final  PaymentRepositories repositories;

  GetPaymentsUseCase(this.repositories);

  // the call function will execute when use object of the class
  Future<List<PaymentModel>?> call() async{
    return await repositories.getPayments();
  }
}