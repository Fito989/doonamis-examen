import 'package:doonamis_examen/constants/custom_colors.dart';
import 'package:doonamis_examen/constants/custom_fonts.dart';
import 'package:doonamis_examen/constants/memory.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.warning_amber_rounded,
            color: CustomColor.get.light_grey,
            size: 120,
          ),
          Text(M.languageCode == 'es' ? 'Algo ha ido mal' : 'Something went wrong',
            style: TextStyle(
              letterSpacing: 1.2,
              color: CustomColor.get.light_grey,
              fontFamily: CustomFonts.get.oxygen_regular,
              fontSize: 20
            ),
          )
        ],
      ),
    );
  }
}
