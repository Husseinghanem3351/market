
import 'package:market/features/payment/domain/entities/payment_entity.dart';

class PaymentModel extends PaymentEntity {
  PaymentModel({
    required super.amount,
    super.id,
    required super.dateAndTime,
    required super.description,
    required super.userName,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      amount: json['amount'],
      dateAndTime: json['dateAndTime'],
      description: json['description'],
      userName: json['userName'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'username': userName,
      'dateAndTime': dateAndTime,
      'description': description,
    };
  }
}
