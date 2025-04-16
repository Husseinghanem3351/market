
import 'package:market/features/employers/domain/entities/employer_entity.dart';

class EmployerModel extends EmployerEntity {
  EmployerModel({
    required super.username,
    required super.password,
    required super.name,
    super.goalAmount,
    super.id,
    super.position,
    super.salary,
  });

  factory EmployerModel.fromJson(Map<String, dynamic> json) {
    return EmployerModel(
      name: json['name'],
      password: json['password'],
      username: json['userName'],
      goalAmount: json['goalAmount'],
      position: json['position'],
      salary: json['salary'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'userName': username,
      'goalAmount': goalAmount,
      'password': password,
      'position': position,
      'salary': salary,
    };
  }
}
