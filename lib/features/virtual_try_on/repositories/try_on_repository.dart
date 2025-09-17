import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:tryon/features/virtual_try_on/models/tryOn_status_response.dart';
import '../models/try_on_response.dart';

class TryOnRepository {
  static String get _apiKey => "fa-XTlwSlmDoOq3-uL2Cea4NxrEAq0QtJIzm9Azy";
Future<TryOnResponse> tryOnShirtFromUrl({
  required String actorImageUrl,
  required String garmentImageUrl,
}) async {
  final url = Uri.parse('https://api.fashn.ai/v1/run');

  final body = jsonEncode({
    "model_name": "tryon-v1.6",
    "inputs": {
      "model_image": actorImageUrl,
      "garment_image": garmentImageUrl,
    }
  });

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    },
    body: body,
  );

  if (response.statusCode == 200) {
    return TryOnResponse.fromJson(jsonDecode(response.body));
  } else {
    return TryOnResponse(error: "API Error: ${response.statusCode}");
  }
}

Future<TryOnStatusResponse> getTryOnResult(String id) async {
  final url = Uri.parse('https://api.fashn.ai/v1/status/$id');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $_apiKey',
    },
  );

  if (response.statusCode == 200) {
    log(response.body);
    return TryOnStatusResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch try-on result");
  }
}

}
