import 'package:atly/main.dart';
import 'package:atly/src/presentation/features/pages/messages_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../features/home/cubit/cubit/notification_cubit.dart';
import '../features/user_profile/cubit/profile_cubit.dart';

class MessagesIcon extends StatefulWidget {
  const MessagesIcon({
    this.inverted = false,
    super.key,
  });

  final bool inverted;

  @override
  State<MessagesIcon> createState() => _MessagesIconState();
}

class _MessagesIconState extends State<MessagesIcon> {
  int count = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<ProfileCubit>(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return InkWell(
      onTap: () async {
        await pushNewScreen(
          context,
          screen: MessageListScreen(rooms: []),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationCountUpdated) {
            count = state.count;
          }
          return Badge(
            label: Text('$count'),
            isLabelVisible: count != 0,
            child: SizedBox(
              width: 24,
              height: 24,
              child: Image.asset(
                widget.inverted
                    ? 'assets/icons/message_icon_small_white.png'
                    : 'assets/icons/message_icon_small.png',
                height: screenSize.height * .04,
                fit: BoxFit.fitHeight,
              ),
            ),
          );
        },
      ),
    );
  }
}
