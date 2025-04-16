import 'package:market/features/customers/domain/entities/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  CustomerModel({
    required super.name,
    required super.priceSelling,
    super.deptAmount,
    super.id,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      name: json['name'],
      priceSelling: json['priceSelling'],
      id: json['id'],
      deptAmount: json['deptAmount'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'name':name,
      'priceSelling':priceSelling,
      'deptAmount':deptAmount??0,
    };
  }
}
