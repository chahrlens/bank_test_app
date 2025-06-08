import 'package:bank_test_app/data/models/abstract/drop_down_option.dart';
import 'package:bank_test_app/data/models/line_model.dart';

class Model implements DropdownOption {
  int id;
  String name;
  int lineId;
  DateTime createdAt;
  DateTime updatedAt;
  int status;
  Line? line;

  Model({
    required this.id,
    required this.name,
    required this.lineId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.line,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['id'] as int,
      name: json['name'] as String,
      lineId: json['line_id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      status: json['status'] as int,
      line: json['line'] != null ? Line.fromJson(json['line']) : null,
    );
  }

  @override
  String get label => name;
}
