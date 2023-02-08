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
    return ElevatedButton(
      style: ButtonStyle(
          alignment: MediaQuery.of(context).orientation == Orientation.portrait ? Alignment.centerLeft : Alignment.center,
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.secondary),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)))),
      onPressed: () async {
        Modular.to.navigate('${SeriePage.url}${serie.id}');
      },
      child: MediaQuery.of(context).orientation == Orientation.portrait
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      GeneralConfiguration.get.images_url + serie.posterPath!,
                      height: 200,
                      errorBuilder: (context, object, stack) {
                        return Icon(Icons.error_outline_rounded);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      serie.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.color,
                          fontFamily: CustomFonts.get.oxygen_bold),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      GeneralConfiguration.get.images_url + serie.posterPath!,
                      height: 200,
                      errorBuilder: (context, object, stack) {
                        return Icon(Icons.error_outline_rounded);
                      },
                    ),
                  ),
                ),
                Text(
                  serie.name!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color,
                      fontFamily: CustomFonts.get.oxygen_bold),
                ),
              ],
            ),
    );
  }
}
