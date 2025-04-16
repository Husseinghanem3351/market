import 'package:market/features/rewards/domain/entities/rewards_entity.dart';

class RewardsModel extends RewardsEntity {
  RewardsModel({
    super.id,
    required super.username,
    required super.dateAndTime,
    required super.description,
  });

  factory RewardsModel.fromJson(Map<String, dynamic> json) {
    return RewardsModel(
      description: json['description'],
      id: json['id'],
      dateAndTime: json['dateAndTime'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateAndTime': dateAndTime,
      'description': description,
      'username': username,
    };
  }
}
