class EmployerEntity {
  final int? id;
  final String username;
  final String name;
  final String password;
  final double? salary;
  final String? position;
  final double? goalAmount;

  EmployerEntity({
    required this.username,
    required this.password,
    this.salary,
    this.position,
    this.goalAmount,
    this.id,
    required this.name,
  });
}
