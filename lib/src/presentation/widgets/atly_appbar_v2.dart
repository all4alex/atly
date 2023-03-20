import 'package:atly/src/app/app.dart';
import 'package:atly/src/presentation/widgets/atly_appbar_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../app/app_colors.dart';
import 'messages_icon.dart';

class AtlyAppbarV2 extends StatelessWidget {
  const AtlyAppbarV2({
    super.key,
    required this.onAction1,
    required this.onAction2,
    this.inverted = false,
    this.title,
  });

  final void Function() onAction1;
  final void Function() onAction2;
  final bool inverted;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => onAction1(),
            child: SizedBox(
                width: 30,
                child: Icon(
                  Icons.arrow_back_outlined,
                  size: 24,
                  color: AppColors.appBlue,
                )),
          ),
          Gap(20),
          Expanded(
            child: Text(
              '$title',
              style: AppText.subtitle1.copyWith(
                fontFamily: 'Poppins',
                color: Color.fromARGB(255, 60, 80, 105),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            onTap: () => onAction2(),
            child: SizedBox(
                width: 30,
                child: Icon(
                  Icons.more_vert_outlined,
                  color: AppColors.appBlue,
                )),
          ),
        ],
      ),
    );
  }
}
