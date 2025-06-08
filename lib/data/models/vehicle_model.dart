import 'package:bank_test_app/data/models/fuel_types_model.dart';
import 'package:bank_test_app/data/models/model_model.dart';
import 'package:bank_test_app/data/models/transmissions_types_model.dart';

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
  FuelTypesModel fuelType;
  TransmissionsTypesModel transmissionType;
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
    required this.fuelType,
    required this.transmissionType,
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
      fuelType: FuelTypesModel.fromJson(json['fuel_type']),
      transmissionType: TransmissionsTypesModel.fromJson(
        json['transmission_type'],
      ),
      registrationDate: DateTime.parse(json['registration_date'] as String),
      imageUrl: json['image_url'] as String?,
      description: json['description'] as String?,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      status: json['status'] as int,
      model: json['model'] != null ? Model.fromJson(json['model']) : null,
    );
  }

  Map<String, dynamic> postJson() {
    return {
      'plate': plateNumber,
      'color': color,
      'transmissionType': transmissionType.id,
      'fuelType': fuelType.id,
      'modelId': modelId,
      'engineNumber': engineNumber,
      'vim': vim,
      'mileage': mileage,
      'registrationDate': registrationDate.toIso8601String(),
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  Map<String, dynamic> putJson() {
    return {
      'id': id,
      'plate': plateNumber,
      'color': color,
      'transmissionType': transmissionType.id,
      'fuelType': fuelType.id,
      'modelId': modelId,
      'engineNumber': engineNumber,
      'vim': vim,
      'mileage': mileage,
      'registrationDate': registrationDate.toIso8601String(),
      'imageUrl': imageUrl,
      'description': description,
    };
  }
}
