import 'package:doonamis_examen/constants/custom_colors.dart';
import 'package:doonamis_examen/constants/custom_fonts.dart';
import 'package:doonamis_examen/enums/page_status_enum.dart';
import 'package:doonamis_examen/pages/series/cubit/series_cubit.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Doonamis Prueba'),
        backgroundColor: CustomColor.get.light_blue,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor.get.white,
      body: BlocProvider(
        create: (_) => SeriesCubit(),
        child: BlocBuilder<SeriesCubit, SeriesState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state.pageStatus == PageStatusEnum.loaded) {
              return SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    widthFactor: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Column(
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(
                                  state.serieList!.length,
                                  (i) => SerieListItem(
                                      serie: state.serieList![i]))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.arrow_back_ios_rounded),
                                  color: CustomColor.get.light_blue,
                                  disabledColor: Colors.transparent,
                                  onPressed: state.page == 1
                                      ? null
                                      : () async {
                                          await ReadContext(context)
                                              .read<SeriesCubit>()
                                              .fetchPage(page: (state.page ?? 1) - 1);
                                        }),
                              Text(
                                '${state.page} / ${state.totalPages}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: CustomColor.get.light_blue,
                                    fontFamily: CustomFonts.get.oxygen_bold),
                              ),
                              IconButton(
                                  icon: Icon(Icons.arrow_forward_ios_rounded),
                                  color: CustomColor.get.light_blue,
                                  onPressed: state.page == state.totalPages
                                      ? null
                                      : () async {
                                          await ReadContext(context)
                                              .read<SeriesCubit>()
                                              .fetchPage(page: (state.page ?? 1) + 1);
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
      ),
    );
  }
}
