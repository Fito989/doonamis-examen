import 'dart:convert';

import 'package:doonamis_examen/api/logger.dart';
import 'package:doonamis_examen/api/php_api.dart';
import 'package:doonamis_examen/constants/map_keys/map_keys.dart';
import 'package:doonamis_examen/constants/response_codes.dart';
import 'package:doonamis_examen/database/database.dart';
import 'package:doonamis_examen/models/serie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class SeriesGetters {
  Future<Serie?> getSerie({required int? id}) async {
    if (id == null) {
      return null;
    }
    http.Response response;
    Serie serie;
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final serieDao = database.serieDao;
      final localSerie = await serieDao.findSerieById(id).first;

      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        return localSerie;
      }
      response = await PhpApiRepository().get(
          function: MapKeys.function.get_serie,
          uri: id.toString(),
          timeout: 10);

      if (response.statusCode == ResponseCodes.get.success) {
        Map responseBody = json.decode(response.body);

        serie = Serie(
            id: responseBody[MapKeys.body.id],
            name: responseBody[MapKeys.body.name],
            overview: responseBody[MapKeys.body.overview],
            firstAirDate: responseBody[MapKeys.body.first_air_date],
            lastAirDate: responseBody[MapKeys.body.last_air_date],
            voteAverage: responseBody[MapKeys.body.vote_average],
            voteCount: responseBody[MapKeys.body.vote_count],
            inProduction: responseBody[MapKeys.body.in_production],
            posterPath: responseBody[MapKeys.body.poster_path],
            page: localSerie?.page ?? 1
        );
        await serieDao.updateSerie(serie);
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
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final serieDao = database.serieDao;
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        series = [];
        int totalPages = 1;
        await serieDao.findAllSeriesByPage(page).then((localSeries) {
          for (var serie in localSeries) {
            series.add(serie);
          }
        });

        await serieDao.findAllSeries().then((localSeries) {
          for (var serie in localSeries) {
            if (serie.page != null && serie.page! > totalPages) {
              totalPages = serie.page!;
            }
          }
        });
        final formattedResponse = {
          MapKeys.body.series: series,
          MapKeys.body.total_pages: totalPages
        };
        return formattedResponse;
      }
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
                  page: page,
                  posterPath: data[i][MapKeys.body.poster_path],
                )
        );
        for (var serie in series) {
          serieDao.insertSerie(serie);
        }
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
