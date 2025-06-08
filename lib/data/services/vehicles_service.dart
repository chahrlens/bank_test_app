import 'dart:convert';
import 'package:bank_test_app/data/models/brand_model.dart';
import 'package:bank_test_app/data/models/fuel_types_model.dart';
import 'package:bank_test_app/data/models/line_model.dart';
import 'package:bank_test_app/data/models/model_model.dart';
import 'package:bank_test_app/data/models/pair.dart';
import 'package:bank_test_app/data/models/transmissions_types_model.dart';
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
    try {
      final result = await _httpProvider.getApi('/catalogs/vehicles', params);
      if (result.first != null) {
        if (kDebugMode) {
          print(result.first);
          print(result.second);
        }
        Iterable list = jsonDecode(result.first);
        final List<VehicleModel> vehicles =
            list.map((vehicle) => VehicleModel.fromJson(vehicle)).toList();
        return Pair(vehicles, result.second);
      } else {
        return Pair(null, result.second);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching vehicles: $e');
      }
      return Pair(null, WebServiceResponse('1', e.toString()));
    }
  }

  Future<Pair<List<Brand>?, WebServiceResponse>> getBrands() async {
    try {
      final result = await _httpProvider.getApi('/catalogs/brands', null);
      if (result.first != null) {
        Iterable list = jsonDecode(result.first);
        final List<Brand> brands =
            list.map((brand) => Brand.fromJson(brand)).toList();
        return Pair(brands, result.second);
      } else {
        return Pair(null, result.second);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching brands: $e');
      }
      return Pair(null, WebServiceResponse('1', e.toString()));
    }
  }

  Future<Pair<List<Model>?, WebServiceResponse>> getModels() async {
    try {
      final result = await _httpProvider.getApi('/catalogs/models', null);
      if (result.first != null) {
        Iterable list = jsonDecode(result.first);
        final List<Model> models =
            list.map((model) => Model.fromJson(model)).toList();
        return Pair(models, result.second);
      } else {
        return Pair(null, result.second);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching models: $e');
      }
      return Pair(null, WebServiceResponse('1', e.toString()));
    }
  }

  Future<Pair<List<Line>?, WebServiceResponse>> getLines() async {
    try {
      final result = await _httpProvider.getApi('/catalogs/lines', null);
      if (result.first != null) {
        Iterable list = jsonDecode(result.first);
        final List<Line> lines =
            list.map((line) => Line.fromJson(line)).toList();
        return Pair(lines, result.second);
      } else {
        return Pair(null, result.second);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching lines: $e');
      }
      return Pair(null, WebServiceResponse('1', e.toString()));
    }
  }

  //
  // /fuel-types
  Future<Pair<List<FuelTypesModel>?, WebServiceResponse>> getFuelTypes() async {
    try {
      final result = await _httpProvider.getApi('/catalogs/fuel-types', null);
      if (result.first != null) {
        Iterable list = jsonDecode(result.first);
        final List<FuelTypesModel> fuelTypes =
            list.map((fuelType) => FuelTypesModel.fromJson(fuelType)).toList();
        return Pair(fuelTypes, result.second);
      } else {
        return Pair(null, result.second);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching fuel types: $e');
      }
      return Pair(null, WebServiceResponse('1', e.toString()));
    }
  }

  ///transmissions-type
  Future<Pair<List<TransmissionsTypesModel>?, WebServiceResponse>>
  getTransmissionsTypes() async {
    try {
      final result = await _httpProvider.getApi(
        '/catalogs/transmissions-types',
        null,
      );
      if (result.first != null) {
        Iterable list = jsonDecode(result.first);
        final List<TransmissionsTypesModel> transmissionsTypes =
            list.map((e) => TransmissionsTypesModel.fromJson(e)).toList();
        return Pair(transmissionsTypes, result.second);
      }
      return Pair(null, result.second);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching transmissions types: $e');
      }
      return Pair(null, WebServiceResponse('1', e.toString()));
    }
  }

  Future<WebServiceResponse> addVehicle(VehicleModel vehicle) async {
    try {
      final body = jsonEncode(vehicle.postJson());
      final response = await _httpProvider.postApi('/catalogs/vehicles', body);
      if (response.second != null) {
        return response.second!;
      } else {
        return WebServiceResponse('0', 'Vehicle added successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding vehicle: $e');
      }
      return WebServiceResponse('1', e.toString());
    }
  }

  Future<WebServiceResponse> updateVehicle(VehicleModel vehicle) async {
    try {
      final body = jsonEncode(vehicle.putJson());
      final response = await _httpProvider.putApi('/catalogs/vehicles', body);
      if (response.second != null) {
        return response.second!;
      } else {
        return WebServiceResponse('0', 'Vehicle updated successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating vehicle: $e');
      }
      return WebServiceResponse('1', e.toString());
    }
  }
}
