import 'package:bank_test_app/data/models/abstract/drop_down_option.dart';
class TransmissionsTypesModel implements DropdownOption {
  int id;
  String name;

  TransmissionsTypesModel({required this.id, required this.name});
  factory TransmissionsTypesModel.fromJson(Map<String, dynamic> json) {
    return TransmissionsTypesModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  @override
  String get label => name;
}
