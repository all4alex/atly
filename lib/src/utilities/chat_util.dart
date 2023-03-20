import 'dart:ui';

import 'package:atly/src/utilities/logger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:intl/intl.dart';

import '../app/app_colors.dart';

const colors = [
  Color(0xffff6767),
  Color(0xff66e0da),
  Color(0xfff5a2d9),
  Color(0xfff0c722),
  Color(0xff6a85e5),
  Color(0xfffd9a6f),
  Color(0xff92db6e),
  Color(0xff73b8e5),
  Color(0xfffd7590),
  Color(0xffc78ae5),
];

Color getUserAvatarNameColor(types.User user) {
  final index = user.id.hashCode % colors.length;
  return colors[index];
}

String getUserName(types.User user) =>
    '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();

String getChatTitle(types.Room room) {
  String allUsers = '';
  for (types.User user in room.users) {
    allUsers = '$allUsers${user.firstName}, ';
  }
  return room.name ?? allUsers;
}

String getLastMessage(types.Room room) {
  String lastMessage = '';

  if (room.lastMessages != null) {
    types.TextMessage textMessage =
        room.lastMessages!.first as types.TextMessage;

    lastMessage = textMessage.text;
  }
  return lastMessage;
}

Widget buildAvatar(types.Room room) {
  var color = Colors.transparent;

  final hasImage = room.imageUrl != null;
  final name = room.name ?? '';

  return Container(
    child: CircleAvatar(
      backgroundColor: hasImage ? AppColors.appOrange : color,
      backgroundImage: hasImage
          ? CachedNetworkImageProvider(room.imageUrl!)
          : CachedNetworkImageProvider('https://i.pravatar.cc/300'),
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
