import 'package:bank_test_app/data/models/model_model.dart';

class VehicleModel {
  int id;
  int modelId;
  int userId;
  String vim;
  String? color;
  String? engineNumber;
  int mileage;
  DateTime createdAt;
  String? plateNumber;
  String? fuelType;
  String? transmissionType;
  DateTime registrationDate;
  String? imageUrl;
  String? description;
  DateTime updatedAt;
  int status;
  Model? model;

  VehicleModel({
    required this.id,
    required this.modelId,
    required this.userId,
    required this.vim,
    this.color,
    this.engineNumber,
    required this.mileage,
    required this.createdAt,
    this.plateNumber,
    this.fuelType,
    this.transmissionType,
    required this.registrationDate,
    this.imageUrl,
    this.description,
    required this.updatedAt,
    required this.status,
    this.model,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] as int,
      modelId: json['model_id'] as int,
      userId: json['user_id'] as int,
      vim: json['vim'] as String,
      color: json['color'] as String?,
      engineNumber: json['engine_number'] as String?,
      mileage: json['mileage'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      plateNumber: json['plate_number'] as String?,
      fuelType: json['fuel_type'] as String?,
      transmissionType: json['transmission_type'] as String?,
      registrationDate: DateTime.parse(json['registration_date'] as String),
      imageUrl: json['image_url'] as String?,
      description: json['description'] as String?,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      status: json['status'] as int,
      model: json['model'] != null ? Model.fromJson(json['model']) : null,
    );
  }
}
