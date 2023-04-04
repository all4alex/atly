import 'package:atly/src/app/app.dart';
import 'package:atly/src/app/app_text.dart';
import 'package:atly/src/presentation/features/pages/cubit/chat_cubit.dart';
import 'package:atly/src/presentation/features/pages/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'add_message_modal.dart';

class AddActionModalBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
                width: MediaQuery.of(context).size.width * 0.5,
                child: GFButton(
                  onPressed: () {
                    Navigator.pop(context);
                    print('Event button pressed');
                  },
                  text: 'Event',
                  shape: GFButtonShape.pills,
                  color: AppColors.appBlue,
                  textStyle: AppText.button.copyWith(
                      fontWeight: FontWeight.bold, color: AppColors.appWhite),
                ),
              ),
              Gap(12),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
                width: MediaQuery.of(context).size.width * 0.5,
                child: GFButton(
                    onPressed: () {
                      Navigator.pop(context);
                      print('Pitch button pressed');
                    },
                    text: 'Pitch',
                    shape: GFButtonShape.pills,
                    color: AppColors.appPink,
                    textStyle: AppText.button.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.appWhite)),
              ),
              Gap(12),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.1,
                child: GFButton(
                    onPressed: () async {
                      await showCupertinoModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        overlayStyle: SystemUiOverlayStyle(),
                        backgroundColor: Colors.transparent,
                        builder: (context) => BlocProvider(
                          create: (context) => ChatCubit(),
                          child: AddMessageModal(),
                        ),
                      ).then((value) {
                        if (value != null) {
                          showCupertinoModalBottomSheet(
                              context: context,
                              useRootNavigator: true,
                              overlayStyle: SystemUiOverlayStyle(),
                              builder: (context) => MessageScreen(room: value));
                        }
                        return;
                      });
                    },
                    text: 'Message',
                    shape: GFButtonShape.pills,
                    color: AppColors.appWhite,
                    textStyle: AppText.button.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.iconBlue,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
