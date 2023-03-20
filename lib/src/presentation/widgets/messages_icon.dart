import 'package:atly/main.dart';
import 'package:atly/src/presentation/features/pages/messages_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class MessagesIcon extends StatelessWidget {
  const MessagesIcon({
    this.inverted = false,
    super.key,
  });

  final bool inverted;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return StreamBuilder<List<types.Room>>(
      stream: FirebaseChatCore.instance.rooms(),
      initialData: const [],
      builder: (context, snapshot) {
        List<types.Room> rooms = [];
        if (snapshot.connectionState == ConnectionState.done ||
            snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.hasData) {
            rooms = snapshot.data!;
          }
        }
        return InkWell(
          onTap: () async {
            await pushNewScreen(
              selectedTabScreenContext!,
              screen: MessageListScreen(rooms: rooms),
              withNavBar: true, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.slideUp,
            );
          },
          child: Badge(
            label: Text('${rooms.length}'),
            isLabelVisible: rooms.isNotEmpty,
            child: SizedBox(
              width: 24,
              height: 24,
              child: Image.asset(
                inverted
                    ? 'assets/icons/message_icon_small_white.png'
                    : 'assets/icons/message_icon_small.png',
                height: screenSize.height * .04,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        );
      },
    );
  }
}
