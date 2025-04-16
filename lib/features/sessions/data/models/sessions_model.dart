import 'package:market/features/sessions/domain/entities/sessions_entity.dart';

class SessionsModel extends SessionsEntity {
  SessionsModel({
    super.id,
    required super.username,
    required super.dateAndTime,
    required super.sellingAmount,
    required super.buyingAmount,
  });

  factory SessionsModel.fromJson(Map<String, dynamic> json) {
    return SessionsModel(
      id: json['id'],
      username: json['username'],
      dateAndTime: json['dateAndTime'],
      sellingAmount: json['sellingAmount'],
      buyingAmount: json['buyingAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateAndTime': dateAndTime,
      'sellingAmount': sellingAmount,
      'buyingAmount': buyingAmount,
      'username': username,
    };
  }
}
