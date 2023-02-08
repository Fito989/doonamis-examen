import 'package:bloc/bloc.dart';
import 'package:doonamis_examen/constants/memory.dart';
import 'package:doonamis_examen/enums/page_status_enum.dart';
import 'package:doonamis_examen/themes/app_themes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'generic_state.dart';

class GenericCubit extends Cubit<GenericState> {
  GenericCubit()
      : super(GenericState(
            pageStatus: PageStatusEnum.loading,
            themeData: AppThemes.appThemeData[AppTheme.lightTheme])) {
    changeLanguage();
  }

  Future<void> changeLanguage() async {
    emit(state.copyWithProps(pageStatus: PageStatusEnum.loading));
    final String languageCode = M.languageCode == 'es' ? 'en' : 'es';
    M.languageCode = languageCode;
    emit(state.copyWithProps(
        pageStatus: PageStatusEnum.loaded, languageCode: languageCode));
  }

  Future<void> changeTheme() async {
    emit(state.copyWithProps(pageStatus: PageStatusEnum.loading));
    final ThemeData? themeData =
        state.themeData == AppThemes.appThemeData[AppTheme.lightTheme]
            ? AppThemes.appThemeData[AppTheme.darkTheme]
            : AppThemes.appThemeData[AppTheme.lightTheme];
    emit(state.copyWithProps(
        pageStatus: PageStatusEnum.loaded, themeData: themeData));
  }
}
