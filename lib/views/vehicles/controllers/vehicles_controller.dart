import 'package:bank_test_app/data/models/brand_model.dart';
import 'package:bank_test_app/data/models/fuel_types_model.dart';
import 'package:bank_test_app/data/models/line_model.dart';
import 'package:bank_test_app/data/models/model_model.dart';
import 'package:bank_test_app/data/models/transmissions_types_model.dart';
import 'package:bank_test_app/data/services/vehicles_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VehiclesController extends GetxController {
  final VehiclesService _vehiclesService = VehiclesService();
  RxList<Brand> brands = <Brand>[].obs;
  RxList<Model> models = <Model>[].obs;
  RxList<Line> lines = <Line>[].obs;
  RxList<TransmissionsTypesModel> transmissionTypes =
      <TransmissionsTypesModel>[].obs;
  RxList<FuelTypesModel> fuelTypes = <FuelTypesModel>[].obs;

  Brand? selectedBrand;
  Model? selectedModel;
  Line? selectedLine;
  TransmissionsTypesModel? selectedTransmissionType;
  FuelTypesModel? selectedFuelType;

  TextEditingController vimController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController engineNumberController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController fuelTypeController = TextEditingController();
  TextEditingController transmissionTypeController = TextEditingController();
  TextEditingController mileageController = TextEditingController();
  TextEditingController registrationDateController = TextEditingController();
  TextEditingController brandsController = TextEditingController();
  TextEditingController modelsController = TextEditingController();
  TextEditingController linesController = TextEditingController();
  TextEditingController transmissionTypesController = TextEditingController();
  TextEditingController fuelTypesController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  void onClose() {
    vimController.dispose();
    colorController.dispose();
    engineNumberController.dispose();
    plateNumberController.dispose();
    fuelTypeController.dispose();
    transmissionTypeController.dispose();

    descriptionController.dispose();
    super.onClose();
  }

  Future<void> fetchCatalogs() async {
    try {
      final results = await Future.wait([
        _vehiclesService.getBrands(),
        _vehiclesService.getModels(),
        _vehiclesService.getLines(),
        _vehiclesService.getTransmissionsTypes(),
        _vehiclesService.getFuelTypes(),
      ]);
      final test = results.every((t) => t.first != null);
      if (test) {
        brands.assign(results[0].first! as Brand);
        models.assign(results[1].first! as Model);
        lines.assign(results[2].first! as Line);
        transmissionTypes.assign(results[3].first! as TransmissionsTypesModel);
        fuelTypes.assign(results[4].first! as FuelTypesModel);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching catalogs: $e');
    }
  }

  Future<void> addVehicle() async {
    // Aquí puedes implementar la lógica para agregar un vehículo
    // Por ejemplo, enviar los datos a una API o guardarlos localmente
    print('Adding vehicle with VIM: ${vimController.text}');
  }

  Future<void> editVehicle(int vehicleId) async {
    // Aquí puedes implementar la lógica para editar un vehículo existente
    // Por ejemplo, enviar los datos actualizados a una API o guardarlos localmente
    print('Editing vehicle with ID: $vehicleId and VIM: ${vimController.text}');
  }

  String? notEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }
}
