import 'package:atly/src/utilities/chat_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:fluttericon/font_awesome_icons.dart';
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
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          StreamBuilder<List<types.Room>>(
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
                      padding: EdgeInsets.only(top: size.height * .15),
                      itemBuilder: (context, index) {
                        types.Room room = rooms[index];
                        return InkWell(
                            onTap: () async {
                              pushNewScreen(
                                context,
                                screen: MessageScreen(room: room),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: ListTile(
                              leading: _buildAvatar(
                                room,
                              ),
                              title: Text(
                                '${room.name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                              ),
                              subtitle: Text(
                                'Last message will display here ....',
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
                      itemCount: rooms.length);
                }
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    ));
  }

  void initializeFlutterFire() async {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        setState(() {
          _user = user;
        });
      });
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget _buildAvatar(types.Room room) {
    var color = Colors.transparent;

    if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
          (u) => u.id != _user!.uid,
        );

        color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        // Do nothing if other user is not found.
      }
    }

    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage:
            hasImage ? CachedNetworkImageProvider(room.imageUrl!) : null,
        radius: 20,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }
}
