import 'package:atly/src/app/app_colors.dart';
import 'package:atly/src/app/app_loader.dart';
import 'package:atly/src/presentation/widgets/atly_appbar.dart';
import 'package:atly/src/presentation/widgets/atly_appbar_v2.dart';
import 'package:atly/src/presentation/widgets/bx_scaffold.dart';
import 'package:atly/src/utilities/chat_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'package:flutter/material.dart';

import 'message_screen.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key, required this.rooms});
  final List<types.Room> rooms;

  static const String routeName = '/register';
  static const String screenName = 'RegisterScreen';

  static ModalRoute route({required List<types.Room> rooms}) =>
      MaterialPageRoute(
          builder: (context) => MessageListScreen(
                rooms: rooms,
              ),
          settings: RouteSettings(name: routeName));
  @override
  State<MessageListScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageListScreen> {
  List<types.Room> rooms = [];

  @override
  void initState() {
    super.initState();
    rooms = widget.rooms;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.appBlue,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.appWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 15.0, // soften the shadow
                spreadRadius: 5.0, //extend the shadow
                offset: Offset(
                  5.0, // Move to right 5  horizontally
                  5.0, // Move to bottom 5 Vertically
                ),
              )
            ],
          ),
          child: Column(
            children: [
              AtlyAppbarV2(
                onAction1: () {
                  Navigator.of(context).pop();
                },
                onAction2: () {
                  Navigator.of(context).pop();
                },
                title: 'Messages',
              ),
              Expanded(
                child: StreamBuilder<List<types.Room>>(
                  stream: FirebaseChatCore.instance.rooms(),
                  initialData: rooms,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done ||
                        snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Something went wrong'));
                      }
                      if (snapshot.hasData) {
                        rooms = snapshot.data!;
                        rooms.removeWhere(
                            (element) => element.lastMessages == null);
                        return rooms.isNotEmpty
                            ? ListView.separated(
                                itemBuilder: (context, index) {
                                  types.Room room = rooms[index];
                                  if (room.lastMessages == null) {
                                    return SizedBox();
                                  } else {}

                                  return InkWell(
                                      onTap: () async {
                                        showCupertinoModalBottomSheet(
                                            context: context,
                                            useRootNavigator: true,
                                            overlayStyle:
                                                SystemUiOverlayStyle(),
                                            builder: (context) =>
                                                MessageScreen(room: room));
                                      },
                                      child: ListTile(
                                        leading: buildAvatar(
                                          room,
                                        ),
                                        title: Text(
                                          getChatTitle(room),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                        ),
                                        subtitle: Text(
                                          getLastMessageSText(room),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                        ),
                                        trailing: IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.more_horiz)),
                                      ));
                                },
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                itemCount: rooms.length)
                            : Center(
                                child: Text('No Messages'),
                              );
                      }
                    }
                    return Center(child: AppLoader.loaderOne);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
