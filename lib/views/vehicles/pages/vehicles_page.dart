import 'package:bank_test_app/data/models/brand_model.dart';
import 'package:bank_test_app/data/models/fuel_types_model.dart';
import 'package:bank_test_app/data/models/line_model.dart';
import 'package:bank_test_app/data/models/model_model.dart';
import 'package:bank_test_app/data/models/transmissions_types_model.dart';
import 'package:bank_test_app/views/vehicles/controllers/vehicles_controller.dart';
import 'package:bank_test_app/widgets/custom_drown_down_widget.dart';
import 'package:bank_test_app/widgets/custom_input.dart';
import 'package:bank_test_app/widgets/layout.dart';
import 'package:bank_test_app/widgets/primary_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class VehiclesPage extends ConsumerStatefulWidget {
  const VehiclesPage({super.key});

  @override
  ConsumerState<VehiclesPage> createState() => _VehiclesPageState();
}

class _VehiclesPageState extends ConsumerState<VehiclesPage> {
  late VehiclesController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  dynamic args = Get.arguments;
  bool editMode = false;

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Loading...');
      if (editMode) {
        await _controller.editVehicle(args['vehicleId']);
      } else {
        await _controller.addVehicle();
      }
      EasyLoading.dismiss();

      Get.back();
      EasyLoading.showSuccess(
        editMode
            ? 'Vehicle updated successfully'
            : 'Vehicle added successfully',
      );
    } else {
      EasyLoading.showError('Please fill in all required fields');
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = Get.put(VehiclesController());
    if (args != null) {
      editMode = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: editMode ? 'Edit Vehicle' : 'Add Vehicles',
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Text('Vehicles Page'),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx(
                          () => CustomDrownDownWidget<Brand>(
                            label: 'Brands',
                            hintText: 'Brands',
                            controller: _controller.brandsController,
                            dropdownMenuEntries:
                                _controller.brands
                                    .map<DropdownMenuEntry<Brand>>(
                                      (e) => DropdownMenuEntry(
                                        value: e,
                                        label: e.name,
                                      ),
                                    )
                                    .toList(),
                            onSelected: (Brand? value) {
                              _controller.selectedBrand = value;
                              _controller.models.clear();
                              _controller.lines.clear();
                              _controller.selectedModel = null;
                              _controller.selectedLine = null;
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Obx(
                          () => CustomDrownDownWidget<Model>(
                            label: 'Models',
                            hintText: 'Models',
                            controller: _controller.modelsController,
                            dropdownMenuEntries:
                                _controller.models
                                    .map<DropdownMenuEntry<Model>>(
                                      (e) => DropdownMenuEntry(
                                        value: e,
                                        label: e.name,
                                      ),
                                    )
                                    .toList(),
                            onSelected: (Model? value) {
                              _controller.selectedModel = value;
                              _controller.lines.clear();
                              _controller.selectedLine = null;
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Obx(
                          () => CustomDrownDownWidget<Line>(
                            label: 'Lines',
                            hintText: 'Lines',
                            controller: _controller.linesController,
                            dropdownMenuEntries:
                                _controller.lines
                                    .map<DropdownMenuEntry<Line>>(
                                      (e) => DropdownMenuEntry(
                                        value: e,
                                        label: e.name,
                                      ),
                                    )
                                    .toList(),
                            onSelected: (Line? value) {
                              _controller.selectedLine = value;
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        CustomInput(
                          controller: _controller.vimController,
                          label: 'Vim',
                          validator: _controller.notEmptyValidator,
                        ),
                        SizedBox(height: 16),
                        CustomInput(
                          controller: _controller.colorController,
                          label: 'Color',
                          validator: _controller.notEmptyValidator,
                        ),
                        SizedBox(height: 16),
                        CustomInput(
                          controller: _controller.engineNumberController,
                          label: 'Engine Number',
                          validator: _controller.notEmptyValidator,
                        ),
                        SizedBox(height: 16),
                        CustomInput(
                          controller: _controller.mileageController,
                          label: 'Mileage',
                          validator: _controller.notEmptyValidator,
                        ),
                        SizedBox(height: 16),
                        CustomInput(
                          controller: _controller.registrationDateController,
                          label: 'Registration Date',
                          validator: _controller.notEmptyValidator,
                        ),
                        SizedBox(height: 16),
                        CustomInput(
                          controller: _controller.plateNumberController,
                          label: 'Plate Number',
                          validator: _controller.notEmptyValidator,
                        ),
                        SizedBox(height: 16),
                        CustomInput(
                          controller: _controller.descriptionController,
                          label: 'Description',
                          validator: _controller.notEmptyValidator,
                        ),
                        SizedBox(height: 16),
                        Obx(
                          () => CustomDrownDownWidget<TransmissionsTypesModel>(
                            label: 'Transmission Type',
                            hintText: 'Select Transmission Type',
                            controller: _controller.transmissionTypeController,
                            dropdownMenuEntries:
                                _controller.transmissionTypes
                                    .map<
                                      DropdownMenuEntry<TransmissionsTypesModel>
                                    >(
                                      (e) => DropdownMenuEntry(
                                        value: e,
                                        label: e.name,
                                      ),
                                    )
                                    .toList(),
                            onSelected: (TransmissionsTypesModel? value) {
                              _controller.selectedTransmissionType = value;
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Obx(
                          () => CustomDrownDownWidget<FuelTypesModel>(
                            label: 'Fuel Type',
                            hintText: 'Select Fuel Type',
                            controller: _controller.fuelTypeController,
                            dropdownMenuEntries:
                                _controller.fuelTypes
                                    .map<DropdownMenuEntry<FuelTypesModel>>(
                                      (e) => DropdownMenuEntry(
                                        value: e,
                                        label: e.name,
                                      ),
                                    )
                                    .toList(),
                            onSelected: (FuelTypesModel? value) {
                              _controller.selectedFuelType = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              PrimaryActionButton(label: 'Guardar', onTap: _handleSubmit),
            ],
          );
        },
      ),
    );
  }
}
