import 'package:bank_test_app/data/models/abstract/drop_down_option.dart';

class Brand implements DropdownOption {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  int status;

  Brand({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      status: json['status'] as int,
    );
  }

  @override
  String get label => name;
}
