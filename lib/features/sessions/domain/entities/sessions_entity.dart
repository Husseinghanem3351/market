
class SessionsEntity {
  final int? id;
  final String username;
  final String dateAndTime;
  final String sellingAmount;
  final String buyingAmount;

  SessionsEntity({
    required this.username,
    required this.dateAndTime,
    required this.sellingAmount,
    required this.buyingAmount,
    this.id,
  });
}
