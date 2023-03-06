import 'package:atly/app/app_colors.dart';
import 'package:atly/app/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class NavSpeedDial extends StatelessWidget {
  const NavSpeedDial(
      {super.key,
      required this.onEvent,
      required this.onPitch,
      required this.onMessage,
      required this.onToss,
      required this.onBlast});
  final void Function() onEvent;
  final void Function() onPitch;
  final void Function() onMessage;
  final void Function() onToss;
  final void Function() onBlast;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIconTheme: IconThemeData(size: 28.0),
      backgroundColor: Colors.white,
      visible: true,
      activeIcon: Icons.close,
      icon: Icons.add,
      iconTheme: IconThemeData(color: AppColors.appGrey, size: 25),
      curve: Curves.bounceInOut,
      childPadding: EdgeInsets.only(bottom: 5),
      spacing: 20,
      childMargin: EdgeInsets.only(right: 5),
      childrenButtonSize: Size(50, 50),
      children: [
        SpeedDialChild(
          child: Icon(
            Icons.post_add_sharp,
            color: AppColors.appGrey,
          ),
          backgroundColor: AppColors.appOriginalWhite,
          onTap: onBlast,
          label: 'Blast',
          labelBackgroundColor: AppColors.appOriginalWhite,
          labelStyle: AppText.caption
              .copyWith(color: AppColors.appGrey, fontWeight: FontWeight.bold),
        ),
        SpeedDialChild(
          child: Icon(
            Icons.post_add_sharp,
            color: AppColors.appGrey,
          ),
          backgroundColor: AppColors.appOriginalWhite,
          onTap: onToss,
          label: 'Toss',
          labelBackgroundColor: AppColors.appOriginalWhite,
          labelStyle: AppText.caption
              .copyWith(color: AppColors.appGrey, fontWeight: FontWeight.bold),
        ),
        SpeedDialChild(
          child: Icon(
            Icons.message,
            color: AppColors.appBlue,
          ),
          backgroundColor: AppColors.appOriginalWhite,
          onTap: onMessage,
          label: 'Message',
          labelBackgroundColor: AppColors.appOriginalWhite,
          labelStyle: AppText.caption.copyWith(color: AppColors.appBlue),
        ),
        SpeedDialChild(
          child: Icon(Icons.event_available, color: AppColors.appOriginalWhite),
          backgroundColor: AppColors.appPink,
          onTap: onPitch,
          label: 'Pitch',
          labelBackgroundColor: AppColors.appPink,
          labelStyle:
              AppText.caption.copyWith(color: AppColors.appOriginalWhite),
        ),
        SpeedDialChild(
          child: Icon(Icons.event, color: AppColors.appOriginalWhite),
          backgroundColor: AppColors.appBlue,
          onTap: onEvent,
          label: 'Event',
          labelBackgroundColor: AppColors.appBlue,
          labelStyle:
              AppText.caption.copyWith(color: AppColors.appOriginalWhite),
        ),
      ],
    );
  }
}
