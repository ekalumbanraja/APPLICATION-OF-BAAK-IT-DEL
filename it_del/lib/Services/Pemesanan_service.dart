import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:it_del/Models/api_response.dart';
import 'package:it_del/Models/kaos.dart';
import 'package:it_del/Services/globals.dart';
import 'package:it_del/Services/User_service.dart';

Future<ApiResponse> PemesananKaos(int kaos_id, int jumlah_pesanan,
    int jenis_pembayaran, int jumlahh_nominal) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response =
        await http.post(Uri.parse(baseURL + 'pemesanan'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'kaos_id': kaos_id,
      'jumlah_pesanan': jumlah_pesanan,
      'jenis_pembayaran': jenis_pembayaran,
      'jumlahh_nominal': jumlahh_nominal,
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        break;
      case 401:
        apiResponse.error = unauthrorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = 'server error $e';
  }
  return apiResponse;
}

Future<ApiResponse> getKaos() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(baseURL + 'kaos'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = (jsonDecode(response.body)['Kaos'] as List)
            .map((p) => Kaos.fromJson(p))
            .toList();
        break;
      case 401:
        // Handle unauthorized case
        break;
      default:
        // Handle other error cases
        print("Server Response: ${response.body}");
        break;
    }
  } catch (e) {
    // Handle server error
    print("Error in getRuangan: $e");
  }
  return apiResponse;
}
