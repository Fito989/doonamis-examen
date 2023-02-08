// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/foundation.dart';

class GeneralConfiguration {
  const GeneralConfiguration();

  static const GeneralConfiguration get = GeneralConfiguration();

  static const String SERVER_URL = 'api.themoviedb.org';

  bool get functions_log => kReleaseMode ? false : false;

  bool get errors_log => kReleaseMode ? false : false;

  String get api_url => 'https://$SERVER_URL/3/tv';

  String get default_app_language => 'es_ES';

  String get movies_api_key  => 'c6aeee577586ba38e487b74dfede5deb';

  String get images_url  => 'https://image.tmdb.org/t/p/w200';
}
