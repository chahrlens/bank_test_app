class VehicleModel {
  int id;
  String description;
  String imageUrl;
  String vim;

  VehicleModel({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.vim,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] as int,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      vim: json['vim'] as String,
    );
  }
}
