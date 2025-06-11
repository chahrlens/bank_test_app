import 'package:bank_test_app/data/models/abstract/drop_down_option.dart';
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

  List<VehicleStatus> vehicleStatuses = [
    VehicleStatus(1, 'Available'),
    VehicleStatus(2, 'Sold'),
    VehicleStatus(3, 'In Service'),
    VehicleStatus(4, 'Damaged'),
  ];

  RxList<TransmissionsTypesModel> transmissionTypes =
      <TransmissionsTypesModel>[].obs;
  RxList<FuelTypesModel> fuelTypes = <FuelTypesModel>[].obs;

  Brand? selectedBrand;
  Model? selectedModel;
  Line? selectedLine;
  TransmissionsTypesModel? selectedTransmissionType;
  FuelTypesModel? selectedFuelType;

  VehicleModel? vehicle;
  VehicleStatus? selectedVehicleStatus;

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
  TextEditingController vehicleStatusController = TextEditingController();

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

  void retrieveVehicleData(dynamic data) {
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
      selectedModel = vehicle?.model;
      selectedLine = selectedModel?.line;

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
      selectedVehicleStatus = vehicleStatuses.firstWhereOrNull(
        (st) => st.id == vehicle?.status,
      );
    }
  }

  dynamic getValueFiltered(dynamic value) {
    if (value.toString().isEmpty) {
      return null;
    }
    return value;
  }

  Future<String> updateVehicle() async {
    if (vehicle == null) {
      return 'No vehicle data to update';
    }
    if (selectedModel == null) {
      return 'Please select a model';
    }
    if (selectedTransmissionType == null) {
      return 'Please select a transmission type';
    }
    if (selectedFuelType == null) {
      return 'Please select a fuel type';
    }
    final VehicleModel newVehicle = VehicleModel.copyFrom(
      father: vehicle!,
      vim: getValueFiltered(vimController.text),
      color: getValueFiltered(colorController.text),
      modelId: selectedModel!.id,
      engineNumber: getValueFiltered(engineNumberController.text),
      plate: getValueFiltered(plateNumberController.text),
      fuelType: selectedFuelType!,
      transmissionType: selectedTransmissionType!,
      mileage: int.tryParse(mileageController.text) ?? 0,
      registrationDate: DateTime.parse(registrationDateController.text),
      model: selectedModel!,
      status: selectedVehicleStatus?.id ?? 1,
      userId: vehicle!.userId,
      description: getValueFiltered(descriptionController.text),
    );

    final result = await _vehiclesService.updateVehicle(newVehicle);
    return result.message;
  }

  Future<String> addVehicle() async {
    if (selectedModel == null) {
      return 'Please select a model';
    }
    if (selectedTransmissionType == null) {
      return 'Please select a transmission type';
    }
    if (selectedFuelType == null) {
      return 'Please select a fuel type';
    }
    if (selectedModel == null) {
      return 'Please select a model';
    }

    final newVehicle = VehicleModel(
      id: 0,
      vim: vimController.text,
      color: colorController.text,
      modelId: selectedModel!.id,
      engineNumber: engineNumberController.text,
      plateNumber: plateNumberController.text,
      fuelType: selectedFuelType!,
      transmissionType: selectedTransmissionType!,
      mileage: int.tryParse(mileageController.text) ?? 0,
      registrationDate: DateTime.parse(registrationDateController.text),
      model: selectedModel!,
      status: selectedVehicleStatus?.id ?? 1, // Default to 'Available'
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
      userId: 1,
      description: descriptionController.text,
    );

    final result = await _vehiclesService.addVehicle(newVehicle);
    return result.message;
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

class VehicleStatus implements DropdownOption {
  int id;
  String description;

  VehicleStatus(this.id, this.description);

  @override
  String get label => description;
}
