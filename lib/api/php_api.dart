// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:doonamis_examen/constants/functions.dart';
import 'package:doonamis_examen/constants/general_configuration.dart';
import 'package:doonamis_examen/constants/map_keys/map_keys.dart';
import 'package:doonamis_examen/constants/memory.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PhpApiRepository {
  Future<http.Response> get(
          {required String function,
          Map<String, dynamic>? body,
          Map<String, String>? headers,
          int? timeout,
          String uri = '',
          Map<String, String>? parameters}) async =>
      _get(function, body ?? {}, headers, timeout, uri, parameters);

  Future<http.Response> _get(
      String function,
      Map<String, dynamic> body,
      Map<String, String>? headers,
      timeout,
      String uri,
      Map<String, String>? parameters) async {
    final apiFunction = Functions.get.function(function)!;
    http.Response response;
    try {
      final queryParams = {
        MapKeys.parameter.api_key: GeneralConfiguration.get.movies_api_key,
        MapKeys.parameter.language: M.languageCode,
      };

      queryParams.addAll(parameters ?? {});

      final parsedUri =
          Uri.parse(GeneralConfiguration.get.api_url + apiFunction + uri)
              .replace(queryParameters: queryParams);

      response = await http
          .get(parsedUri, headers: headers)
          .timeout(Duration(seconds: timeout ?? 3));

      if (GeneralConfiguration.get.functions_log) {
        debugPrint('\nPosting...');
        debugPrint('Target url:' +
            Uri.http(GeneralConfiguration.get.api_url, apiFunction + uri,
                    queryParams)
                .path);
        debugPrint('Body sent: ' + body.toString());
        debugPrint('Response status code: ' + (response.statusCode).toString());
        debugPrint('Response body: ' + response.body);
      }
    } catch (e, stackTrace) {
      if (GeneralConfiguration.get.functions_log) {
        debugPrint('\nPosting...');
        debugPrint('Target url:' +
            Uri.http(GeneralConfiguration.get.api_url, apiFunction + uri).path);
        debugPrint('Body sent: ' + body.toString());
        debugPrint(e.toString());
        debugPrint(stackTrace.toString());
      }
      rethrow;
    }

    return response;
  }
}
