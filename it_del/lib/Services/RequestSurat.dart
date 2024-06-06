import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:it_del/Models/api_response.dart';
import 'package:it_del/Models/request_surat.dart';
import 'package:it_del/Services/globals.dart';
import 'package:it_del/Services/User_service.dart';

Future<ApiResponse> CreateRequestSurat(String reason) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(baseURL + 'surat'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'reason': reason,
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = unauthrorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = 'server error';
  }
  return apiResponse;
}

Future<ApiResponse> getRequestSurat() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(baseURL + 'surat'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = (jsonDecode(response.body)['RequestSurat'] as List)
            .map((p) => RequestSurat.fromJson(p))
            .toList();
        break;
      case 401:
        apiResponse.error = unauthrorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        // Log the actual server response for debugging
        print("Server Response: ${response.body}");
        break;
    }
  } catch (e) {
    apiResponse.error = 'server error';
    print("Error in getIzinKeluar: $e");
  }
  return apiResponse;
}

Future<ApiResponse> updateRequestSurat(int id, String reason) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(
      Uri.parse(baseURL + 'surat/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        'reason': reason,
      },
    );

    // Handle response based on status code
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = 'Unauthorized';
        break;
      default:
        apiResponse.error = 'Something went wrong';
        break;
    }
  } catch (e) {
    apiResponse.error = 'Server error: $e';
  }
  return apiResponse;
}

Future<ApiResponse> DeleteRequestSurat(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(Uri.parse(baseURL + 'surat/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthrorized;
        break;
    }
  } catch (e) {}
  return apiResponse;
}

Future<ApiResponse> approveSuratRequest(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(
      Uri.parse(baseURL + 'admin/surat/approve/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 404:
        apiResponse.error = 'Leave request not found.';
        break;
      case 401:
        apiResponse.error = 'Unauthorized';
        break;
      default:
        apiResponse.error = 'Something went wrong';
        break;
    }
  } catch (e) {
    apiResponse.error = 'Error: $e';
  }
  return apiResponse;
}

Future<ApiResponse> rejectedSuratRequest(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(
      Uri.parse(baseURL + 'admin/surat/rejected/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 404:
        apiResponse.error = 'Leave request not found.';
        break;
      case 401:
        apiResponse.error = 'Unauthorized';
        break;
      default:
        apiResponse.error = 'Something went wrong';
        break;
    }
  } catch (e) {
    apiResponse.error = 'Error: $e';
  }
  return apiResponse;
}

Future<ApiResponse> getAdminSurat() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(baseURL + 'admin/surat'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = (jsonDecode(response.body)['RequestSurat'] as List)
            .map((p) => RequestSurat.fromJson(p))
            .toList();
        break;
      case 401:
        apiResponse.error = unauthrorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        // Log the actual server response for debugging
        print("Server Response: ${response.body}");
        break;
    }
  } catch (e) {
    apiResponse.error = 'server error';
    print("Error in getIzinKeluar: $e");
  }
  return apiResponse;
}

Future<ApiResponse> getSemuaAdminSurat() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(baseURL + 'admin/surats'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = (jsonDecode(response.body)['RequestSurat'] as List)
            .map((p) => RequestSurat.fromJson(p))
            .toList();
        break;
      case 401:
        apiResponse.error = unauthrorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        // Log the actual server response for debugging
        print("Server Response: ${response.body}");
        break;
    }
  } catch (e) {
    apiResponse.error = 'server error';
    print("Error in getIzinKeluar: $e");
  }
  return apiResponse;
}
