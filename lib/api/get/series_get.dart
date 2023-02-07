import 'dart:convert';

import 'package:doonamis_examen/api/logger.dart';
import 'package:doonamis_examen/api/php_api.dart';
import 'package:doonamis_examen/constants/map_keys/map_keys.dart';
import 'package:doonamis_examen/constants/response_codes.dart';
import 'package:doonamis_examen/models/creator.dart';
import 'package:doonamis_examen/models/serie.dart';
import 'package:http/http.dart' as http;

class SeriesGetters {
  Future<Serie?> getSerie({required int? id}) async {
    if (id == null) {
      return null;
    }
    http.Response response;
    Serie serie;
    try {
      response = await PhpApiRepository().get(
          function: MapKeys.function.get_serie,
          uri: id.toString(),
          timeout: 10);

      if (response.statusCode == ResponseCodes.get.success) {
        Map responseBody = json.decode(response.body);
        List<Creator>? creators;
        List? creatorBody = (responseBody[MapKeys.body.created_by] as List);

        if (creatorBody.isNotEmpty) {
          creators = List.generate(creatorBody.length,
                  (i) => Creator(
                      id: creatorBody[i][MapKeys.body.id],
                      name: creatorBody[i][MapKeys.body.name],
                      gender: creatorBody[i][MapKeys.body.gender]
                  )
          );
        }
        serie = Serie(
            id: responseBody[MapKeys.body.id],
            name: responseBody[MapKeys.body.name] ?? '',
            overview: responseBody[MapKeys.body.overview] ?? '',
            firstAirDate: responseBody[MapKeys.body.first_air_date] ?? '',
            lastAirDate: responseBody[MapKeys.body.last_air_date] ?? '',
            voteAverage: responseBody[MapKeys.body.vote_average] ?? 0,
            voteCount: responseBody[MapKeys.body.vote_count] ?? 0,
            inProduction: responseBody[MapKeys.body.in_production] ?? '',
            posterPath: responseBody[MapKeys.body.poster_path] ?? '',
            creators: creators
        );

        return serie;
      } else {
        Logger.logUnknownError(
            response.statusCode.toString(), response.body.toString(),
            function: MapKeys.function.get_serie);
      }
    } catch (e, stackTrace) {
      Logger.logException(e, stackTrace, function: MapKeys.function.get_serie);
    }
    return null;
  }

  Future<Map<String, dynamic>?> getSeries({int page = 1}) async {
    http.Response response;
    List<Serie> series;
    try {
      response = await PhpApiRepository().get(
          function: MapKeys.function.get_series,
          timeout: 10,
          parameters: {MapKeys.parameter.page: page.toString()});

      if (response.statusCode == ResponseCodes.get.success) {
        final responseBody = json.decode(response.body);
        final data = responseBody[MapKeys.body.results] as List;
        series = List.generate(
            data.length,
            (i) => Serie(
                  id: data[i][MapKeys.body.id],
                  name: data[i][MapKeys.body.name],
                  posterPath: data[i][MapKeys.body.poster_path],
                ));
        final formattedResponse = {
          MapKeys.body.series: series,
          MapKeys.body.total_pages: responseBody[MapKeys.body.total_pages]
        };

        return formattedResponse;
      } else {
        Logger.logUnknownError(
            response.statusCode.toString(), response.body.toString(),
            function: MapKeys.function.get_series);
      }
    } catch (e, stackTrace) {
      Logger.logException(e, stackTrace, function: MapKeys.function.get_series);
    }
    return null;
  }
}
