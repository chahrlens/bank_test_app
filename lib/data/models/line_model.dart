import 'package:bank_test_app/data/models/brand_model.dart';

class Line {
  int id;
  String name;
  int brandId;
  DateTime createdAt;
  DateTime updatedAt;
  int status;
  Brand? brand;

  Line({
    required this.id,
    required this.name,
    required this.brandId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.brand,
  });

  factory Line.fromJson(Map<String, dynamic> json) {
    return Line(
      id: json['id'] as int,
      name: json['name'] as String,
      brandId: json['brand_id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      status: json['status'] as int,
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
    );
  }
}