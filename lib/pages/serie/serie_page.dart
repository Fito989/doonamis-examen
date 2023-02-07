import 'package:doonamis_examen/constants/custom_colors.dart';
import 'package:doonamis_examen/constants/custom_fonts.dart';
import 'package:doonamis_examen/constants/general_configuration.dart';
import 'package:doonamis_examen/constants/memory.dart';
import 'package:doonamis_examen/enums/page_status_enum.dart';
import 'package:doonamis_examen/generic_bloc/generic_cubit.dart';
import 'package:doonamis_examen/pages/serie/cubit/serie_cubit.dart';
import 'package:doonamis_examen/pages/series/series_page.dart';
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
    return BlocBuilder<GenericCubit, GenericState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                        onTap: () async {
                          ReadContext(context)
                              .read<GenericCubit>()
                              .changeLanguage();
                        },
                        child: Text(M.languageCode.toUpperCase(),
                            style: TextStyle(
                                fontSize: 16,
                                color: CustomColor.get.white,
                                fontFamily: CustomFonts.get.oxygen_bold))))
              ],
              title: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () async {
                      Modular.to.navigate(SeriesPage.url);
                    },
                  ),
                  Text('volver al listado'),
                ],
              ),
              backgroundColor: CustomColor.get.light_blue,
            ),
            resizeToAvoidBottomInset: false,
            backgroundColor: CustomColor.get.white,
            body: BlocProvider(
              create: (_) => SerieCubit(serieId: serieId),
              child: BlocBuilder<SerieCubit, SerieState>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  if (state.pageStatus == PageStatusEnum.error) {
                    return ErrorPage();
                  } else if (state.pageStatus == PageStatusEnum.loaded) {
                    return SingleChildScrollView(
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Column(
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
                                      fontFamily: CustomFonts.get.oxygen_bold),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Image.network(
                                          GeneralConfiguration.get.images_url +
                                              (state.serie?.posterPath ?? ''),
                                          errorBuilder:
                                              (context, exception, stackTrace) {
                                        return ErrorPage();
                                      })),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
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
                                                      ? Icon(Icons.check_box,
                                                          color: CustomColor
                                                              .get.red)
                                                      : Icon(
                                                          Icons.smart_display,
                                                          color: CustomColor
                                                              .get.green),
                                                ),
                                                TextSpan(
                                                    text: (state.serie
                                                                ?.inProduction ??
                                                            false)
                                                        ? 'Finalizada'
                                                        : 'En emisión',
                                                    style: TextStyle(
                                                        letterSpacing: 1.2,
                                                        fontSize: 16,
                                                        fontFamily: CustomFonts
                                                            .get.oxygen_regular,
                                                        color: (state.serie
                                                                    ?.inProduction ??
                                                                false)
                                                            ? CustomColor
                                                                .get.red
                                                            : CustomColor
                                                                .get.green)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                              'Primera emisión: ${state.serie?.firstAirDate}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: CustomFonts
                                                      .get.oxygen_regular,
                                                  letterSpacing: 1.2)),
                                        ),
                                        (state.serie?.inProduction ?? false)
                                            ? Text(
                                                'Ultima emisión: ${state.serie?.lastAirDate}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: CustomFonts
                                                        .get.oxygen_regular,
                                                    letterSpacing: 1.2))
                                            : state.serie?.nextEpisodeAirDate !=
                                                    null
                                                ? Text(
                                                    'Siguiente emisión: ${state.serie?.nextEpisodeAirDate}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: CustomFonts
                                                            .get.oxygen_regular,
                                                        letterSpacing: 1.2))
                                                : Container(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RatingBar.builder(
                                              ignoreGestures: true,
                                              initialRating:
                                                  ((state.serie?.voteAverage ??
                                                          10) /
                                                      2),
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 12,
                                              ),
                                              onRatingUpdate: (double value) {},
                                            ),
                                            Text(
                                                '(${(state.serie?.voteCount ?? 0)})',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontFamily: CustomFonts
                                                        .get.oxygen_bold,
                                                    letterSpacing: 1.2))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 20),
                                    child: Text('${state.serie?.overview}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily:
                                                CustomFonts.get.oxygen_regular,
                                            letterSpacing: 1.2)),
                                  )
                                ],
                              ),
                              state.serie?.creators != null &&
                                      state.serie!.creators!.isNotEmpty
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 50.0),
                                      child: Column(
                                        children: [
                                          Text(
                                              state.serie!.creators!.length > 1
                                                  ? 'Creadores'
                                                  : 'Creador',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontFamily: CustomFonts
                                                      .get.oxygen_bold,
                                                  letterSpacing: 1.2)),
                                          Column(
                                              children: List.generate(
                                                  state.serie!.creators!.length,
                                                  (i) =>
                                                      state.serie!.creators![i]
                                                                  .name !=
                                                              null
                                                          ? RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                      text:
                                                                          '${state.serie!.creators![i].name}',
                                                                      style: TextStyle(
                                                                          letterSpacing:
                                                                              1.2,
                                                                          fontSize:
                                                                              18,
                                                                          fontFamily: CustomFonts
                                                                              .get
                                                                              .oxygen_regular,
                                                                          color: CustomColor
                                                                              .get
                                                                              .light_grey)),
                                                                  WidgetSpan(
                                                                    child: (state.serie!.creators![i].gender ==
                                                                            1)
                                                                        ? Icon(
                                                                            Icons
                                                                                .female,
                                                                            color: CustomColor
                                                                                .get.pink)
                                                                        : Icon(
                                                                            Icons
                                                                                .male,
                                                                            color:
                                                                                CustomColor.get.deep_blue),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : Container())),
                                        ],
                                      ),
                                    )
                                  : Container()
                            ]),
                      ),
                    );
                  }
                  return Loader();
                },
              ),
            ));
      },
    );
  }
}
