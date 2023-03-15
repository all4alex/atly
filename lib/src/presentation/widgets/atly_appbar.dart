import 'package:atly/src/presentation/widgets/atly_appbar_subtitle.dart';
import 'package:flutter/material.dart';

import '../../app/app_colors.dart';

class AtlyAppbar extends StatelessWidget {
  const AtlyAppbar({
    super.key,
    required this.onAction1,
    required this.onAction2,
    required this.onAction3,
    this.subtitle,
  });

  final void Function() onAction1;
  final void Function() onAction2;
  final void Function() onAction3;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: AppColors.iconBlue,
                      ),
                      onPressed: onAction1),
                  SizedBox(
                      width: size.width * .15,
                      child: Image.asset('assets/icons/atly_text_logo.png')),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.search),
                    color: AppColors.iconBlue,
                    onPressed: onAction2,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.chat_rounded,
                      color: AppColors.iconBlue,
                    ),
                    onPressed: onAction3,
                  ),
                ],
              )
            ],
          ),
          subtitle ?? const SizedBox(),
        ],
      ),
    );
  }
}
