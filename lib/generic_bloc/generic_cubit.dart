import 'package:bloc/bloc.dart';
import 'package:doonamis_examen/constants/memory.dart';
import 'package:doonamis_examen/enums/page_status_enum.dart';
import 'package:equatable/equatable.dart';

part 'generic_state.dart';

class GenericCubit extends Cubit<GenericState> {
  GenericCubit() : super(GenericState(pageStatus: PageStatusEnum.loading)) {
    changeLanguage();
  }

  Future<void> changeLanguage() async {
    emit(state.copyWithProps(
        pageStatus: PageStatusEnum.loading));
    final String languageCode = M.languageCode == 'es' ? 'en' : 'es';
    M.languageCode = languageCode;
    emit(state.copyWithProps(
        pageStatus: PageStatusEnum.loaded, languageCode: languageCode));
  }
}
