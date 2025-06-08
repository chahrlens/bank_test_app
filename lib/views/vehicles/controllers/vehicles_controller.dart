import 'package:bank_test_app/data/models/brand_model.dart';
import 'package:bank_test_app/data/models/fuel_types_model.dart';
import 'package:bank_test_app/data/models/line_model.dart';
import 'package:bank_test_app/data/models/model_model.dart';
import 'package:bank_test_app/data/models/transmissions_types_model.dart';
import 'package:bank_test_app/data/models/vehicle_model.dart';
import 'package:bank_test_app/data/services/vehicles_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class VehiclesController extends GetxController {
  final VehiclesService _vehiclesService = VehiclesService();
  RxList<Brand> brands = <Brand>[].obs;

  List<Model> allModels = <Model>[];
  List<Line> allLines = <Line>[];
  RxList<Model> selectedModels = <Model>[].obs;
  RxList<Line> selectedLines = <Line>[].obs;

  RxList<TransmissionsTypesModel> transmissionTypes =
      <TransmissionsTypesModel>[].obs;
  RxList<FuelTypesModel> fuelTypes = <FuelTypesModel>[].obs;

  Brand? selectedBrand;
  Model? selectedModel;
  Line? selectedLine;
  TransmissionsTypesModel? selectedTransmissionType;
  FuelTypesModel? selectedFuelType;

  VehicleModel? vehicle;

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

  Future<String?> fetchCatalogs() async {
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
        brands.assignAll(results[0].first! as List<Brand>);
        allModels.assignAll(results[1].first! as List<Model>);
        allLines.assignAll(results[2].first! as List<Line>);
        transmissionTypes.assignAll(
          results[3].first! as List<TransmissionsTypesModel>,
        );
        fuelTypes.assignAll(results[4].first! as List<FuelTypesModel>);
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  void onBrandSelected(Brand? brand) {
    selectedLines.clear();
    selectedModels.clear();
    selectedModel = null;
    selectedLine = null;
    selectedTransmissionType = null;
    selectedFuelType = null;

    selectedBrand = brand;
    if (brand != null) {
      selectedLines.assignAll(
        allLines.where((line) => line.brandId == brand.id),
      );
    }
  }

  void onSelectedLine(Line? line) {
    selectedLine = line;
    if (line != null) {
      selectedModels.assignAll(
        allModels.where((model) => model.lineId == line.id),
      );
    }
  }

  Future<void> addVehicle() async {
    print('Adding vehicle with VIM: ${vimController.text}');
  }

  Future<void> editVehicle(dynamic data) async {
    if (data is VehicleModel) {
      if (kDebugMode) {
        print('Editing vehicle with VIM: ${vehicle?.vim}');
      }
      vehicle = data;
      selectedModels.assignAll(
        allModels.where((model) => model.lineId == vehicle?.model?.lineId),
      );
      selectedLines.assignAll(
        allLines.where((line) => line.brandId == vehicle?.model?.line?.brandId),
      );

      selectedModels.assignAll(
        allModels.where((model) => model.lineId == vehicle?.model?.lineId),
      );

      selectedLine = vehicle?.model?.line;
      selectedBrand = selectedLine?.brand;
      selectedLine = selectedModel?.line;
      selectedModel = vehicle?.model;

      // Set the text controllers with the vehicle data
      vimController.text = vehicle?.vim ?? '';
      colorController.text = vehicle?.color ?? '';
      engineNumberController.text = vehicle?.engineNumber ?? '';
      plateNumberController.text = vehicle?.plateNumber ?? '';
      mileageController.text = vehicle?.mileage.toString() ?? '';
      registrationDateController.text =
          vehicle?.registrationDate.toIso8601String() ?? '';
      descriptionController.text = vehicle?.description ?? '';
      selectedTransmissionType = vehicle?.transmissionType;
      selectedFuelType = vehicle?.fuelType;
      // Set the selected values for dropdowns
      selectedTransmissionType = vehicle?.transmissionType;
      selectedFuelType = vehicle?.fuelType;
    }
  }

  String? notEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String? dropdownValidator(dynamic value) {
    if (value == null) {
      return 'This field cannot be empty';
    }
    return null;
  }
}
