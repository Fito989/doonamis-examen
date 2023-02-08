import 'package:doonamis_examen/pages/serie/cubit/serie_cubit.dart';
import 'package:doonamis_examen/pages/serie/serie_page.dart';
import 'package:doonamis_examen/pages/series/series_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SerieModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SerieCubit()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(SeriesPage.route, child: (_, args) => SeriesPage(), transition: TransitionType.fadeIn),
    ChildRoute(SeriePage.route, child: (_, args) => SeriePage(serieId: int.parse(args.params['id'])), transition: TransitionType.fadeIn),
  ];
}