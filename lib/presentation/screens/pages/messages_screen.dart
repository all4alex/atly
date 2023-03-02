import 'package:atly/presentation/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import '../../../core/constants/strings.dart';

import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

void _handlePressed(types.User otherUser, BuildContext context) async {
  final room = await FirebaseChatCore.instance.createRoom(otherUser);

  // Navigate to the Chat screen
}

class _MessageScreenState extends State<MessageScreen> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: StreamBuilder<List<types.User>>(
      stream: FirebaseChatCore.instance.users(),
      initialData: const [],
      builder: (context, snapshot) {
        List<types.User> chatUsers = [];
        if (snapshot.connectionState == ConnectionState.done ||
            snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.hasData) {
            chatUsers = snapshot.data!;
            
            ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)
          }
        }
        return const CircularProgressIndicator();
      },
    ));
  }
}
 types.User chatUser = chatUsers[index];
                      Widget item = InkWell(
                          onTap: () async {
                            _handlePressed(chatUser, context);
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              // Display the Flutter Logo image asset.
                              foregroundImage:
                                  NetworkImage('${chatUser.imageUrl}'),
                            ),
                            title: Text(
                              '${chatUser.firstName} ${chatUser.lastName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                            ),
                            subtitle: Text(
                              'online',
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
                      return Column(
                        children: [item, item, item, item, item],
                      );