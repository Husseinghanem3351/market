class CustomerEntity {
  final int? id;
  final String name;
  final double? deptAmount;
  final String priceSelling;

  CustomerEntity({
    this.id,
    required this.name,
    this.deptAmount,
    required this.priceSelling,
  });
}
