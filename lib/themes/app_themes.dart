import 'package:doonamis_examen/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
        scaffoldBackgroundColor: CustomColor.get.white,
        iconTheme: IconThemeData(color: CustomColor.get.very_light_grey),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: CustomColor.get.dark_grey,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: CustomColor.get.light_blue)),
    AppTheme.darkTheme: ThemeData(
      scaffoldBackgroundColor: CustomColor.get.very_light_grey,
      iconTheme: IconThemeData(color: CustomColor.get.white),
      textTheme: TextTheme(
          bodyLarge: TextStyle(
        color: CustomColor.get.white,
      )),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: CustomColor.get.electric_orange),
    )
  };
}

enum AppTheme {
  lightTheme,
  darkTheme,
}
