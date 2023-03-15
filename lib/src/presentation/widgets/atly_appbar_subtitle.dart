import 'package:atly/src/app/app_text.dart';
import 'package:flutter/material.dart';

import '../../app/app_colors.dart';

class AtlyAppbarSubtitle extends StatelessWidget {
  const AtlyAppbarSubtitle({
    super.key,
    required this.subtitle,
  });

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          subtitle,
          style: AppText.subtitle2.copyWith(
            fontFamily: 'Poppins',
            color: AppColors.iconBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
