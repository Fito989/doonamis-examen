import 'package:bloc/bloc.dart';
import 'package:doonamis_examen/api/get/series_get.dart';
import 'package:doonamis_examen/constants/map_keys/map_keys.dart';
import 'package:doonamis_examen/enums/page_status_enum.dart';
import 'package:doonamis_examen/models/serie.dart';
import 'package:equatable/equatable.dart';

part 'series_state.dart';

class SeriesCubit extends Cubit<SeriesState> {
  SeriesCubit() : super(SeriesState(page: 1)) {
    fetchPage();
  }

  Future<void> fetchPage({int page = 1}) async {
    emit(state.copyWithProps(pageStatus: PageStatusEnum.loading));

    Map<String, dynamic>? response =
        await SeriesGetters().getSeries(page: page);

    emit(state.copyWithProps(
        pageStatus: PageStatusEnum.loaded,
        serieList: response?[MapKeys.body.series],
        page: page,
        totalPages: response?[MapKeys.body.total_pages]));
  }
}
