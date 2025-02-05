/* import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RequestType {
  get,
  post,
  put,
  patch,
  delete,
}

mixin BaseService {
  static const String baseUrl =
      'https://6437cb120c58d3b145796117.mockapi.io/api/v1';

  Future request(
    String endpoint, {
    required RequestType requestType,
    Object? body,
  }) async {
    final uri = Uri.parse("$baseUrl/$endpoint");
    final header = {"Content-Type": "application/json"};
    await SharedPreferences.getInstance();

    log("REQUEST URI: $uri");
    log("REQUEST BODY: ${json.encode(body)}");

    Response response;

    try {
      if (requestType == RequestType.post) {
        response = await post(uri, body: json.encode(body), headers: header);
      } else if (requestType == RequestType.get) {
        response = await get(uri, headers: header);
      } else if (requestType == RequestType.patch) {
        response = await patch(uri, body: json.encode(body), headers: header);
      } else if (requestType == RequestType.put) {
        response = await put(uri, body: json.encode(body), headers: header);
      } else if (requestType == RequestType.delete) {
        response = await delete(uri, headers: header);
      } else {
        throw const HttpException("Http method not implemented yet.");
      }
      log("RESPONSE Code:::: ${response.statusCode}");
      log("RESPONSE BODY:::: ${response.body.toString()}");
      if (response.statusCode >= 400) {
        final b = jsonDecode(response.body);
        final message = b['message'] ?? "An error occurred";
        throw HttpException(message);
      }
      return json.decode(response.body);
    } catch (e) {
      log("Exception::::: ${e.toString()}");
      rethrow;
    }
  }
 }*/
