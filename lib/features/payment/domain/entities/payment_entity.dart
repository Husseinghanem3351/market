class PaymentEntity {
  final int? id;
  final String description;
  final double amount;
  final String userName;
  final String dateAndTime;

  PaymentEntity({
    this.id,
    required this.description,
    required this.amount,
    required this.userName,
    required this.dateAndTime,
  });
}
