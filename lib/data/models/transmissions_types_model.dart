class TransmissionsTypesModel {
  int id;
  String name;

  TransmissionsTypesModel({required this.id, required this.name});
  factory TransmissionsTypesModel.fromJson(Map<String, dynamic> json) {
    return TransmissionsTypesModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
