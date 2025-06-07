import 'package:bank_test_app/data/models/vehicle_model.dart';
import 'package:bank_test_app/data/services/vehicles_service.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final VehiclesService _vehiclesService = VehiclesService();

  RxList<VehicleModel> vehicles = <VehicleModel>[].obs;

  Future<String?> fetchVehicles(String? params) async {
    final result = await _vehiclesService.getVehicles(params);
    if (result.first != null) {
      vehicles.assignAll(result.first!);
      return null;
    } else {
      return result.second?.message ?? 'Failed to fetch vehicles';
    }
  }
}
