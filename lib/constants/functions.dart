// ignore_for_file: non_constant_identifier_names

import 'package:doonamis_examen/constants/map_keys/map_keys.dart';

class Functions {
  const Functions();

  static const Functions get = Functions();

  String get _function_get_serie => '/';

  String get _function_get_series => '/popular';

  Map<String, String> get _functions => {
    MapKeys.function.get_serie: _function_get_serie,
    MapKeys.function.get_series: _function_get_series,
  };

  String? function(String key) => _functions[key];
}
