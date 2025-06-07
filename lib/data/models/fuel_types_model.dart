class FuelTypesModel {
  int id;
  String name;

  FuelTypesModel({required this.id, required this.name});
  factory FuelTypesModel.fromJson(Map<String, dynamic> json) {
    return FuelTypesModel(id: json['id'] as int, name: json['name'] as String);
  }
}
