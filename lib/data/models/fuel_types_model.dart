import 'package:bank_test_app/data/models/abstract/drop_down_option.dart';

class FuelTypesModel implements DropdownOption {
  int id;
  String name;

  FuelTypesModel({required this.id, required this.name});
  factory FuelTypesModel.fromJson(Map<String, dynamic> json) {
    return FuelTypesModel(id: json['id'] as int, name: json['name'] as String);
  }

  @override
  String get label => name;
}
