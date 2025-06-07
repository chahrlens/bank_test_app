import 'package:bank_test_app/data/models/pair.dart';
import 'package:bank_test_app/data/models/vehicle_model.dart';
import 'package:bank_test_app/data/models/web_generic_response.dart';
import 'package:bank_test_app/providers/http_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class VehiclesService extends GetConnect {
  final HttpProvider _httpProvider = HttpProvider();

  Future<Pair<List<VehicleModel>?, WebServiceResponse>> getVehicles(
    String? params,
  ) async {
    final result = await _httpProvider.getApi('/catalogs/vehicles', params);
    if (result.first != null) {
      if (kDebugMode) {
        print(result.first);
        print(result.second);
      }
      final List<VehicleModel> vehicles =
          (result.first as List)
              .map((vehicle) => VehicleModel.fromJson(vehicle))
              .toList();
      return Pair(vehicles, result.second);
    } else {
      return Pair(null, result.second);
    }
  }
}
