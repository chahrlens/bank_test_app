import 'package:bank_test_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bank_test_app/data/models/pair.dart';
import 'package:bank_test_app/providers/global_providers.dart';
import 'package:bank_test_app/data/models/web_generic_response.dart';

class HttpProvider {
  String baseUrl = dotenv.env['API_URL'] ?? '';
  WebServiceResponse genericResponse = WebServiceResponse('0', '');
  final List<int> statusCodes = [200, 201, 202, 204];

  Future<String?> getToken() async {
    final user = container.read(userProviderWithOutNotifier).user;
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
      if (params != null && params.isNotEmpty) {
        fullHttpUrl += '?$params';
      }
      final token = await getToken();

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(Uri.parse(fullHttpUrl), headers: headers);

      if (statusCodes.contains(response.statusCode)) {
        if (response.body.isNotEmpty) {
          if (kDebugMode) {
            print('--------------------------------------------------------');
            print('✅ GET Request URL: $fullHttpUrl');
            print('📦 GET Response: ${response.body}');
          }
          return Pair(response.body, genericResponse);
        } else {
          if (kDebugMode) {
            print('✅ GET Request URL: $fullHttpUrl');
            print('⚠️ GET Response: No content');
          }
          return Pair(null, genericResponse);
        }
      } else {
        if (kDebugMode) {
          print('❌ GET Request URL: $fullHttpUrl');
          print(
            '🚨 GET Response Error: ${response.statusCode} - ${response.reasonPhrase}',
          );
        }
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
    Object body,
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
        body: body,
        headers: headers,
      );

      if (statusCodes.contains(response.statusCode)) {
        if (response.body.isNotEmpty) {
          if (kDebugMode) {
            print('✅ POST Request URL: $fullHttpUrl');
            print('📦 POST Body: $body');
            print('📦 POST Response: ${response.body}');
          }
          return Pair(response.body, genericResponse);
        } else {
          if (kDebugMode) {
            print('✅ POST Request URL: $fullHttpUrl');
            print('📦 POST Body: $body');
            print('⚠️ POST Response: No content');
          }
          return Pair(null, genericResponse);
        }
      } else {
        if (kDebugMode) {
          print('❌ POST Request URL: $fullHttpUrl');
          print('📦 POST Body: $body');
          print(
            '🚨 POST Response Error: ${response.statusCode} - ${response.reasonPhrase}',
          );
        }
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
    Object body,
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
        body: body,
        headers: headers,
      );

      if (statusCodes.contains(response.statusCode)) {
        if (response.body.isNotEmpty) {
          if (kDebugMode) {
            print('✅ PUT Request URL: $fullHttpUrl');
            print('📦 PUT Body: $body');
            print('📦 PUT Response: ${response.body}');
          }
          return Pair(response.body, genericResponse);
        } else {
          if (kDebugMode) {
            print('✅ PUT Request URL: $fullHttpUrl');
            print('📦 POST Body: $body');
            print('⚠️ PUT Response: No content');
          }
          return Pair(null, genericResponse);
        }
      } else {
        if (kDebugMode) {
          print('❌ PUT Request URL: $fullHttpUrl');
          print('📦 POST Body: $body');
          print(
            '🚨 PUT Response Error: ${response.statusCode} - ${response.reasonPhrase}',
          );
        }
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
          if (kDebugMode) {
            print('✅ DELETE Request URL: $fullHttpUrl');
            print('📦 DELETE Response: ${response.body}');
          }
          return Pair(response.body, genericResponse);
        } else {
          if (kDebugMode) {
            print('✅ DELETE Request URL: $fullHttpUrl');
            print('⚠️ DELETE Response: No content');
          }
          return Pair(null, genericResponse);
        }
      } else {
        if (kDebugMode) {
          print('❌ DELETE Request URL: $fullHttpUrl');
          print(
            '🚨 DELETE Response Error: ${response.statusCode} - ${response.reasonPhrase}',
          );
        }
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
