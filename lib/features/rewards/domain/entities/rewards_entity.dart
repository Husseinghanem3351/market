
class RewardsEntity {
  final int? id;
  final String username;
  final String dateAndTime;
  final String description;

  RewardsEntity({
    required this.username,
    required this.dateAndTime,
    required this.description,
    this.id,
  });
}
