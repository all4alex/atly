import 'package:atly/src/presentation/widgets/atly_appbar_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../app/app_colors.dart';
import 'messages_icon.dart';

class AtlyAppbar extends StatelessWidget {
  const AtlyAppbar({
    super.key,
    required this.onAction1,
    required this.onAction2,
    this.inverted = false,
    this.subtitle,
  });

  final void Function() onAction1;
  final void Function() onAction2;
  final bool inverted;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 50, bottom: 15),
      alignment: Alignment.bottomCenter,
      height: size.height * .15,
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
                        inverted
                            ? 'assets/icons/hamburger_menu_icon_white.png'
                            : 'assets/icons/hamburger_menu_icon.png',
                        height: size.height * .04,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Gap(10),
                  SizedBox(
                      width: size.width * .15,
                      child: inverted
                          ? Image.asset('assets/icons/atly_text_logo_white.png')
                          : Image.asset('assets/icons/atly_text_logo.png')),
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
                        inverted
                            ? 'assets/icons/search_icon_white.png'
                            : 'assets/icons/search_icon.png',
                        height: size.height * .04,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Gap(10),
                  MessagesIcon(
                    inverted: inverted,
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
