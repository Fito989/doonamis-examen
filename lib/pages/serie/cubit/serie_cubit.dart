import 'package:bloc/bloc.dart';
import 'package:doonamis_examen/api/get/series_get.dart';
import 'package:doonamis_examen/enums/page_status_enum.dart';
import 'package:doonamis_examen/models/serie.dart';
import 'package:equatable/equatable.dart';

part 'serie_state.dart';

class SerieCubit extends Cubit<SerieState> {
  SerieCubit({int? serieId})
      : super(SerieState(pageStatus: PageStatusEnum.loading)) {
    initState(serieId: serieId);
  }

  Future<void> initState({int? serieId}) async {
    Serie? serie;
    try {
      serie = await SeriesGetters().getSerie(id: serieId);
      print('$serie');
      if (serie == null) {
        emit(state.copyWithProps(
          pageStatus: PageStatusEnum.error,
        ));
      } else {
        emit(
            state.copyWithProps(
                pageStatus: PageStatusEnum.loaded, serie: serie));
      }
    } catch (e) {
      emit(state.copyWithProps(
        pageStatus: PageStatusEnum.error,
      ));
    }
  }
}
