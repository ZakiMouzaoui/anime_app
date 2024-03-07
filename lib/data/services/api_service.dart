import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants/api_constants.dart';

class ApiService extends GetxService {
  static ApiService get instance => Get.find();

  Future<dynamic> get(String endpoint) async {
    http.Response response;

    do {
      response = await http.get(Uri.parse('$baseUrl/$endpoint'),
          headers: {"content-type": "application/json"});
    } while (response.statusCode == 429 || response.statusCode == 500);
    return json.decode(response.body);
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, {Map<String, dynamic>? body}) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint'));

    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Successful response
      return json.decode(response.body);
    } else {
      if (response.statusCode == 429) {
        // Handle status code 429 (Too Many Requests) by retrying the request
        return _retryRequest(response.request!.url);
      } else {
        // Handle other error responses
        throw Exception(
            'API request failed with status code ${response.statusCode}');
      }
    }
  }

  Future<dynamic> _retryRequest(Uri url) async {
    // Retry the request using a do-while loop
    http.Response retryResponse;

    do {
      // Implement your retry logic here
      // You can use a retry library or custom logic with a delay before retrying

      // Example using a simple delay before retrying
      await Future.delayed(
          const Duration(seconds: 2)); // Increasing delay with each retry

      // Retry the request
      retryResponse = await http.get(url);
    } while (retryResponse.statusCode ==
        429); // Retry until a non-429 response or a maximum retry count

    return json.decode(retryResponse.body);
  }
}
