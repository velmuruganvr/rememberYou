import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/io_client.dart';

import 'ApiResponse.dart';

enum HttpType { GET, POST, PUT, DELETE }

// Replace localhost with 10.0.2.2 in the URLs you plan to use.
// For HTTP: http://10.0.2.2:5064
// For HTTPS: https://10.0.2.2:7089 (if you're using HTTPS, but for simplicity during

class commonApi {

  // Future<void> SignIn(String email, String password) async {
  //
  //   final response = await http.post(
  //     Uri.parse(''),
  //     headers: {'Content-Type': 'application/json'},
  //     body: '{"email": "string", "password": "string"}',
  //   );
  //
  //   if (response.statusCode == 200) {
  //     // Handle success
  //     print('API Response: ${response.body}');
  //     print('Login successful!');
  //   } else {
  //     // Handle error
  //     print('Login failed: ${response.statusCode}');
  //   }
  // }


  Future<ApiResponse> fetch_Api_Response(
      String url, // The URL for the API endpoint
      HttpType httpType,
      Object? parameters, // Parameters (e.g., email, password)
          {Map<String, String>? headers} // Optional headers
      ) async {
    try {
      final vHeaders = {
        'Content-Type': 'application/json',
        ...?headers,
      };
      http.Response response;

      // Only encode the body if parameters are not null, otherwise set it to null
      final body = parameters != null ? jsonEncode(parameters) : null;

      // Handle different HTTP methods
      switch (httpType) {
        case HttpType.GET:
          response = await http.get(
            Uri.parse(url),
            headers: vHeaders,
          );
          break;

        case HttpType.POST:
          response = await http.post(
            Uri.parse(url),
            headers: vHeaders,
            body: body, // POST should include the body if not null
          );
          break;

        case HttpType.PUT:
          response = await http.put(
            Uri.parse(url),
            headers: vHeaders,
            body: body, // PUT should include the body if not null
          );
          break;

        case HttpType.DELETE:
          response = await http.delete(
            Uri.parse(url),
            headers: vHeaders,
            body: body, // DELETE should include the body if not null
          );
          break;
      }

      // Check if the request was successful
      if (response.statusCode == 200) {
        return ApiResponse(
          success: true,
          message: 'success',
          responseBody: jsonDecode(response.body),
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Request failed: ${response.statusCode}',
          responseBody: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'An error occurred: $e',
      );
    }
  }

}


