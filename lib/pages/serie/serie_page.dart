import 'package:doonamis_examen/constants/custom_colors.dart';
import 'package:doonamis_examen/constants/custom_fonts.dart';
import 'package:doonamis_examen/constants/general_configuration.dart';
import 'package:doonamis_examen/constants/memory.dart';
import 'package:doonamis_examen/enums/page_status_enum.dart';
import 'package:doonamis_examen/generic_bloc/generic_cubit.dart';
import 'package:doonamis_examen/pages/serie/cubit/serie_cubit.dart';
import 'package:doonamis_examen/pages/series/series_page.dart';
import 'package:doonamis_examen/themes/app_themes.dart';
import 'package:doonamis_examen/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../widgets/loader.dart';

class SeriePage extends StatelessWidget {
  static const String url = '/serie/';
  static const String route = '/:id';
  final int serieId;

  const SeriePage({super.key, required this.serieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SerieCubit(serieId: serieId),
      child: BlocConsumer<GenericCubit, GenericState>(
        listener: (context, state) {
          ReadContext(context).read<SerieCubit>().initState(serieId: serieId);
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: GestureDetector(
                            onTap: () async {
                              ReadContext(context)
                                  .read<GenericCubit>()
                                  .changeTheme();
                            },
                            child: Icon(
                              state.themeData ==
                                  AppThemes.appThemeData[AppTheme.darkTheme]
                                  ? Icons.light_mode_rounded
                                  : Icons.dark_mode_rounded,
                              size: 16,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: GestureDetector(
                            onTap: () async {
                              ReadContext(context)
                                  .read<GenericCubit>()
                                  .changeLanguage();
                            },
                            child: Text(M.languageCode.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                                    fontFamily: CustomFonts.get.oxygen_bold))),
                      ),
                    ],
                  )
                ],
                title: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back,
                          color: Theme.of(context).textTheme.bodyLarge?.color),
                      onPressed: () async {
                        Modular.to.navigate(SeriesPage.url);
                      },
                    ),
                    Text(
                        M.languageCode == 'es'
                            ? 'volver al listado'
                            : 'back to list',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontFamily: CustomFonts.get.oxygen_bold)),
                  ],
                ),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: BlocBuilder<SerieCubit, SerieState>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  if (state.pageStatus == PageStatusEnum.error) {
                    return ErrorPage();
                  } else if (state.pageStatus == PageStatusEnum.loaded) {
                    return SingleChildScrollView(
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        '${state.serie?.name}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                            fontFamily:
                                                CustomFonts.get.oxygen_bold),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0),
                                            child: Image.network(
                                                GeneralConfiguration
                                                        .get.images_url +
                                                    (state.serie?.posterPath ??
                                                        ''), errorBuilder:
                                                    (context, exception,
                                                        stackTrace) {
                                              return ErrorPage();
                                            })),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                        child: (state.serie
                                                                    ?.inProduction ??
                                                                false)
                                                            ? Icon(
                                                                Icons.check_box,
                                                                color:
                                                                    CustomColor
                                                                        .get
                                                                        .red)
                                                            : Icon(
                                                                Icons
                                                                    .smart_display,
                                                                color:
                                                                    CustomColor
                                                                        .get
                                                                        .green),
                                                      ),
                                                      TextSpan(
                                                          text: (state.serie
                                                                      ?.inProduction ??
                                                                  false)
                                                              ? M.languageCode ==
                                                                      'es'
                                                                  ? 'Finalizada'
                                                                  : 'Ended'
                                                              : M.languageCode ==
                                                                      'es'
                                                                  ? 'En emisión'
                                                                  : 'In broadcast',
                                                          style: TextStyle(
                                                              letterSpacing:
                                                                  1.2,
                                                              fontSize: 16,
                                                              fontFamily: CustomFonts
                                                                  .get
                                                                  .oxygen_regular,
                                                              color: (state.serie
                                                                          ?.inProduction ??
                                                                      false)
                                                                  ? CustomColor
                                                                      .get.red
                                                                  : CustomColor
                                                                      .get
                                                                      .green)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Text(
                                                    '${M.languageCode == 'es' ? 'Primera emisión' : 'First broadcast'}: ${state.serie?.firstAirDate}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.color,
                                                        fontFamily: CustomFonts
                                                            .get.oxygen_regular,
                                                        letterSpacing: 1.2)),
                                              ),
                                              (state.serie?.inProduction ??
                                                      false)
                                                  ? Text(
                                                      '${M.languageCode == 'es' ? 'Ultima emisión' : 'Last broadcast'}: ${state.serie?.lastAirDate}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Theme.of(context)
                                                              .textTheme
                                                              .bodyLarge
                                                              ?.color,
                                                          fontFamily: CustomFonts
                                                              .get
                                                              .oxygen_regular,
                                                          letterSpacing: 1.2))
                                                  : state.serie
                                                              ?.nextEpisodeAirDate !=
                                                          null
                                                      ? Text(
                                                          '${M.languageCode == 'es' ? 'Siguiente emisión' : 'Next broadcast'}: ${state.serie?.nextEpisodeAirDate}',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.color,
                                                              fontFamily:
                                                                  CustomFonts
                                                                      .get
                                                                      .oxygen_regular,
                                                              letterSpacing:
                                                                  1.2))
                                                      : Container(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RatingBar.builder(
                                                    ignoreGestures: true,
                                                    unratedColor:
                                                        Theme.of(context)
                                                            .iconTheme
                                                            .color,
                                                    initialRating: ((state.serie
                                                                ?.voteAverage ??
                                                            10) /
                                                        2),
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      size: 12,
                                                    ),
                                                    onRatingUpdate:
                                                        (double value) {},
                                                  ),
                                                  Text(
                                                      '(${(state.serie?.voteCount ?? 0)})',
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.color,
                                                          fontFamily:
                                                              CustomFonts.get
                                                                  .oxygen_bold,
                                                          letterSpacing: 1.2))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 20),
                                          child: Text(
                                              '${state.serie?.overview}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.color,
                                                  fontFamily: CustomFonts
                                                      .get.oxygen_regular,
                                                  letterSpacing: 1.2)),
                                        )
                                      ],
                                    ),
                                  ])
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${state.serie?.name}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.color,
                                                fontFamily: CustomFonts
                                                    .get.oxygen_bold),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                    GeneralConfiguration
                                                            .get.images_url +
                                                        (state.serie
                                                                ?.posterPath ??
                                                            ''), errorBuilder:
                                                        (context, exception,
                                                            stackTrace) {
                                                  return ErrorPage();
                                                }))),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: (state.serie
                                                      ?.inProduction ??
                                                      false)
                                                      ? Icon(
                                                      Icons.check_box,
                                                      color:
                                                      CustomColor
                                                          .get
                                                          .red)
                                                      : Icon(
                                                      Icons
                                                          .smart_display,
                                                      color:
                                                      CustomColor
                                                          .get
                                                          .green),
                                                ),
                                                TextSpan(
                                                    text: (state.serie
                                                        ?.inProduction ??
                                                        false)
                                                        ? M.languageCode ==
                                                        'es'
                                                        ? 'Finalizada'
                                                        : 'Ended'
                                                        : M.languageCode ==
                                                        'es'
                                                        ? 'En emisión'
                                                        : 'In broadcast',
                                                    style: TextStyle(
                                                        letterSpacing:
                                                        1.2,
                                                        fontSize: 16,
                                                        fontFamily: CustomFonts
                                                            .get
                                                            .oxygen_regular,
                                                        color: (state.serie
                                                            ?.inProduction ??
                                                            false)
                                                            ? CustomColor
                                                            .get.red
                                                            : CustomColor
                                                            .get
                                                            .green)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(top: 20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 8.0),
                                                  child: Text(
                                                      '${M.languageCode == 'es' ? 'Primera emisión' : 'First broadcast'}: ${state.serie?.firstAirDate}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Theme.of(context)
                                                              .textTheme
                                                              .bodyLarge
                                                              ?.color,
                                                          fontFamily: CustomFonts
                                                              .get.oxygen_regular,
                                                          letterSpacing: 1.2)),
                                                ),
                                                (state.serie?.inProduction ??
                                                    false)
                                                    ? Text(
                                                    '${M.languageCode == 'es' ? 'Ultima emisión' : 'Last broadcast'}: ${state.serie?.lastAirDate}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.color,
                                                        fontFamily: CustomFonts
                                                            .get
                                                            .oxygen_regular,
                                                        letterSpacing: 1.2))
                                                    : state.serie
                                                    ?.nextEpisodeAirDate !=
                                                    null
                                                    ? Text(
                                                    '${M.languageCode == 'es' ? 'Siguiente emisión' : 'Next broadcast'}: ${state.serie?.nextEpisodeAirDate}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Theme.of(
                                                            context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.color,
                                                        fontFamily:
                                                        CustomFonts
                                                            .get
                                                            .oxygen_regular,
                                                        letterSpacing:
                                                        1.2))
                                                    : Container(),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    RatingBar.builder(
                                                      ignoreGestures: true,
                                                      unratedColor:
                                                      Theme.of(context)
                                                          .iconTheme
                                                          .color,
                                                      initialRating: ((state.serie
                                                          ?.voteAverage ??
                                                          10) /
                                                          2),
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 4.0),
                                                      itemBuilder: (context, _) =>
                                                          Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                            size: 12,
                                                          ),
                                                      onRatingUpdate:
                                                          (double value) {},
                                                    ),
                                                    Text(
                                                        '(${(state.serie?.voteCount ?? 0)})',
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            color:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyLarge
                                                                ?.color,
                                                            fontFamily:
                                                            CustomFonts.get
                                                                .oxygen_bold,
                                                            letterSpacing: 1.2))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 20, 50, 20),
                                            child: Text(
                                                  '${state.serie?.overview}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.color,
                                                      fontFamily: CustomFonts
                                                          .get.oxygen_regular,
                                                      letterSpacing: 1.2)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                      ),
                    );
                  }
                  return Loader();
                },
              ));
        },
      ),
    );
  }
}
