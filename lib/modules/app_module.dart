import 'package:doonamis_examen/modules/serie_module.dart';
import 'package:doonamis_examen/pages/series/cubit/series_cubit.dart';
import 'package:doonamis_examen/pages/series/series_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  static const String series = '/';
  static const String serie = '/serie/';


  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SeriesCubit()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(AppModule.series, child: (_, __) => SeriesPage(), transition: TransitionType.fadeIn),
    ModuleRoute(AppModule.serie, module: SerieModule()),
  ];
}
