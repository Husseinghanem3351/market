import 'package:market/global/database.dart';
import '../models/payment_model.dart';

abstract class PaymentsLocalDataSource {
  Future<void> addPayment(PaymentModel payment);

  Future<void> deletePayment(int id);

  Future<void> updatePayment(PaymentModel payment);

  Future<List<PaymentModel>?> getPayments();
}

class PaymentsLocalDataSourceImplementation implements PaymentsLocalDataSource {
  @override
  Future<void> addPayment(PaymentModel payment) async {
    try {
      await database.transaction(
        (txn) => txn.insert(
          'payments',
          payment.toJson(),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> deletePayment(int id) async {
    try {
      await database.rawDelete('delete from payments where id=$id');
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<List<PaymentModel>?> getPayments() async {
    try{final value = await database.rawQuery('select * from payments');
    return value.map<PaymentModel>((e) => PaymentModel.fromJson(e)).toList();
  }catch(error){print(error);}
    return null;}

  @override
  Future<void> updatePayment(PaymentModel paymentModel) async {
    try {
      await database.rawUpdate('update payments set '
          'description="${paymentModel.description}",'
          'userName="${paymentModel.userName}",'
          'amount=${paymentModel.amount},'
          'where id=${paymentModel.id}');
    } catch (error) {
      print(error);
    }
  }
}
