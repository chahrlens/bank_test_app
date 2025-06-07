import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bank_test_app/data/models/pair.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bank_test_app/providers/global_providers.dart';
import 'package:bank_test_app/data/models/web_generic_response.dart';

class HttpProvider {
  String baseUrl = dotenv.env['BASE_URL'] ?? '';
  WebServiceResponse genericResponse = WebServiceResponse('0', '');
  final List<int> statusCodes = [200, 201, 202, 204];
  final container = ProviderContainer();

  Future<String?> getToken() async {
    final user = container.read(userProvider);
    if (user != null) {
      final token = await user.getIdToken();
      return token;
    } else {
      throw Exception('User not authenticated');
    }
  }

  Future<Pair<dynamic, WebServiceResponse>> getApi(
    String endpoint,
    String? params,
  ) async {
    try {
      String fullHttpUrl = baseUrl + endpoint;
      final token = await getToken();

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse(fullHttpUrl + (params != null ? '?$params' : '')),
        headers: headers,
      );

      if (statusCodes.contains(response.statusCode)) {
        if (response.body.isNotEmpty) {
          return Pair(response.body, genericResponse);
        } else {
          return Pair(null, genericResponse);
        }
      } else {
        return Pair(
          null,
          WebServiceResponse(
            response.statusCode.toString(),
            'Error: ${response.reasonPhrase}',
          ),
        );
      }
    } catch (e) {
      return Pair(null, WebServiceResponse('1', e.toString()));
    }
  }

  Future<Pair<dynamic, WebServiceResponse>> postApi(
    String endpoint,
    String? params,
  ) async {
    try {
      String fullHttpUrl = baseUrl + endpoint;
      final token = await getToken();

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.post(
        Uri.parse(fullHttpUrl),
        body: params,
        headers: headers,
      );
      if (statusCodes.contains(response.statusCode)) {
        if (response.body.isNotEmpty) {
          return Pair(response.body, genericResponse);
        } else {
          return Pair(null, genericResponse);
        }
      } else {
        return Pair(
          null,
          WebServiceResponse(
            response.statusCode.toString(),
            'Error: ${response.reasonPhrase}',
          ),
        );
      }
    } catch (e) {
      return Pair(null, WebServiceResponse('1', e.toString()));
    }
  }

  Future<Pair<dynamic, WebServiceResponse>> putApi(
    String endpoint,
    String? params,
  ) async {
    try {
      String fullHttpUrl = baseUrl + endpoint;
      final token = await getToken();

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.put(
        Uri.parse(fullHttpUrl),
        body: params,
        headers: headers,
      );

      if (statusCodes.contains(response.statusCode)) {
        if (response.body.isNotEmpty) {
          return Pair(response.body, genericResponse);
        } else {
          return Pair(null, genericResponse);
        }
      } else {
        return Pair(
          null,
          WebServiceResponse(
            response.statusCode.toString(),
            'Error: ${response.reasonPhrase}',
          ),
        );
      }
    } catch (e) {
      return Pair(null, WebServiceResponse('1', e.toString()));
    }
  }

  Future<Pair<dynamic, WebServiceResponse>> deleteApi(
    String endpoint,
    String? params,
  ) async {
    try {
      String fullHttpUrl = baseUrl + endpoint;
      final token = await getToken();

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.delete(
        Uri.parse(fullHttpUrl + (params != null ? '?$params' : '')),
        headers: headers,
      );

      if (statusCodes.contains(response.statusCode)) {
        if (response.body.isNotEmpty) {
          return Pair(response.body, genericResponse);
        } else {
          return Pair(null, genericResponse);
        }
      } else {
        return Pair(
          null,
          WebServiceResponse(
            response.statusCode.toString(),
            'Error: ${response.reasonPhrase}',
          ),
        );
      }
    } catch (e) {
      return Pair(null, WebServiceResponse('1', e.toString()));
    }
  }
}
