import 'package:doonamis_examen/constants/custom_colors.dart';
import 'package:doonamis_examen/constants/custom_fonts.dart';
import 'package:doonamis_examen/constants/general_configuration.dart';
import 'package:doonamis_examen/models/serie.dart';
import 'package:doonamis_examen/pages/serie/serie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SerieListItem extends StatelessWidget {
  final Serie serie;

  const SerieListItem({Key? key, required this.serie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: ElevatedButton(
          style: ButtonStyle(
              alignment: Alignment.centerLeft,
              backgroundColor:
              MaterialStateProperty.all<Color>(
                  CustomColor.get.light_blue),
              shape: MaterialStateProperty.all<
                  RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          18.0)))),
          onPressed: () async {
            Modular.to.navigate(
                '${SeriePage.url}${serie.id}');
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Image.network(GeneralConfiguration.get.images_url + serie.posterPath!),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(serie.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: 16,
                          color: CustomColor.get.light_grey,
                          fontFamily:
                          CustomFonts.get.oxygen_bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}