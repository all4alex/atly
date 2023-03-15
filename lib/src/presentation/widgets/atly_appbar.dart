import 'package:atly/src/presentation/widgets/atly_appbar_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => onAction1(),
                    child: SizedBox(
                      width: 22,
                      height: 20,
                      child: Image.asset(
                        'assets/icons/hamburger_menu_icon.png',
                        height: size.height * .04,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Gap(10),
                  SizedBox(
                      width: size.width * .15,
                      child: Image.asset('assets/icons/atly_text_logo.png')),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => onAction2(),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        'assets/icons/search_icon.png',
                        height: size.height * .04,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Gap(10),
                  InkWell(
                    onTap: () => onAction3(),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        'assets/icons/message_icon_small.png',
                        height: size.height * .04,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          subtitle ?? const SizedBox(),
        ],
      ),
    );
  }
}
