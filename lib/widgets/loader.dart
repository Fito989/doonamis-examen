import 'package:doonamis_examen/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        semanticsLabel: 'Loader',
        backgroundColor: CustomColor.get.black.withOpacity(0.7),
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
