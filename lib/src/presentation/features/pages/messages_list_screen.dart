import 'package:atly/src/app/app_colors.dart';
import 'package:atly/src/presentation/widgets/bx_scaffold.dart';
import 'package:atly/src/utilities/chat_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'package:flutter/material.dart';

import '../../widgets/atly_appbar.dart';
import 'message_screen.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});
  @override
  State<MessageListScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageListScreen> {
  bool _error = false;
  bool _initialized = false;
  User? _user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      color: AppColors.appWhite,
      child: StreamBuilder<List<types.Room>>(
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

              return ListView.separated(
                  padding: EdgeInsets.only(top: screenSize.height * .15),
                  itemBuilder: (context, index) {
                    types.Room room = rooms[index];
                    return InkWell(
                        onTap: () async {
                          showCupertinoModalBottomSheet(
                              context: context,
                              useRootNavigator: true,
                              overlayStyle: SystemUiOverlayStyle(),
                              backgroundColor: Colors.red,
                              builder: (context) => MessageScreen(room: room));
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
                            '',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                ),
                          ),
                          trailing: IconButton(
                              onPressed: () {}, icon: Icon(Icons.more_horiz)),
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: rooms.length);
            }
          }
          return SizedBox(
              height: 50,
              width: 50,
              child: Center(child: const CircularProgressIndicator()));
        },
      ),
    );
  }
}
