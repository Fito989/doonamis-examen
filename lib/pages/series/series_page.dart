import 'package:doonamis_examen/constants/custom_fonts.dart';
import 'package:doonamis_examen/constants/memory.dart';
import 'package:doonamis_examen/enums/page_status_enum.dart';
import 'package:doonamis_examen/generic_bloc/generic_cubit.dart';
import 'package:doonamis_examen/pages/series/cubit/series_cubit.dart';
import 'package:doonamis_examen/themes/app_themes.dart';
import 'package:doonamis_examen/widgets/error_page.dart';
import 'package:doonamis_examen/widgets/loader.dart';
import 'package:doonamis_examen/widgets/serie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesPage extends StatelessWidget {
  const SeriesPage({super.key});

  static const String route = '/';
  static const String url = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SeriesCubit(),
      child: BlocConsumer<GenericCubit, GenericState>(
        listener: (context, state) {
          ReadContext(context).read<SeriesCubit>().fetchPage();
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  M.languageCode == 'es' ? 'Doonamis Prueba' : 'Doonamis Test',
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontFamily: CustomFonts.get.oxygen_bold)),
              backgroundColor: Theme.of(context).colorScheme.secondary,
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
            ),
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: BlocBuilder<SeriesCubit, SeriesState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                if (state.pageStatus == PageStatusEnum.error) {
                  return ErrorPage();
                } else if (state.pageStatus == PageStatusEnum.loaded) {
                  return SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        widthFactor: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Column(
                            children: [
                              MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: List.generate(
                                          state.serieList!.length,
                                          (i) => Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: SerieListItem(
                                                serie: state.serieList![i]),
                                          )))
                                  : Padding(
                                    padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                                    child: GridView.count(
                                      shrinkWrap: true,
                                    primary: false,
                                    padding: const EdgeInsets.all(20),
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 3,
                                        children: List.generate(
                                            state.serieList!.length,
                                            (i) => SerieListItem(
                                                serie: state.serieList![i]))),
                                  ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.arrow_back_ios_rounded),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      disabledColor: Colors.transparent,
                                      onPressed: state.page == 1
                                          ? null
                                          : () async {
                                              await ReadContext(context)
                                                  .read<SeriesCubit>()
                                                  .fetchPage(
                                                      page: (state.page ?? 1) -
                                                          1);
                                            }),
                                  Text(
                                    '${state.page} / ${state.totalPages}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontFamily:
                                            CustomFonts.get.oxygen_bold),
                                  ),
                                  IconButton(
                                      icon:
                                          Icon(Icons.arrow_forward_ios_rounded),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      onPressed: state.page == state.totalPages
                                          ? null
                                          : () async {
                                              await ReadContext(context)
                                                  .read<SeriesCubit>()
                                                  .fetchPage(
                                                      page: (state.page ?? 1) +
                                                          1);
                                            }),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Loader();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
