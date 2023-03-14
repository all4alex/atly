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
    return SafeArea(
      child: Container(
        height: size.width * .05,
        padding: EdgeInsets.only(left: 15),
        alignment: Alignment.bottomLeft,
        child: Text(
          subtitle,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontFamily: 'Poppins',
                color: AppColors.iconBlue,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
