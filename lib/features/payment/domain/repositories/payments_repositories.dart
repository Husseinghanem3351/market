import 'package:market/features/payment/data/models/payment_model.dart';

abstract class PaymentRepositories {
  Future<void> deletePayment(int id);
  Future<void> addPayment(PaymentModel paymentModel);
  Future<void> updatePayment(PaymentModel paymentModel);
  Future<List<PaymentModel>?> getPayments();

}