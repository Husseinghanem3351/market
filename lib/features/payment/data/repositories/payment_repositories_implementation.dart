import 'package:market/features/payment/data/data_sources/payments_local_data_source.dart';
import 'package:market/features/payment/data/models/payment_model.dart';
import 'package:market/features/payment/domain/repositories/payments_repositories.dart';

class PaymentRepositoriesImplementation implements PaymentRepositories {
  final PaymentsLocalDataSource paymentsLocalDataSource =
      PaymentsLocalDataSourceImplementation();

  @override
  Future<void> addPayment(PaymentModel paymentModel) async {
    await paymentsLocalDataSource.addPayment(paymentModel);
  }

  @override
  Future<void> deletePayment(int id) async {
    await paymentsLocalDataSource.deletePayment(id);
  }

  @override
  Future<List<PaymentModel>?> getPayments() async {
    return await paymentsLocalDataSource.getPayments();
  }

  @override
  Future<void> updatePayment(PaymentModel paymentModel) async {
    await paymentsLocalDataSource.updatePayment(paymentModel);
  }
}
