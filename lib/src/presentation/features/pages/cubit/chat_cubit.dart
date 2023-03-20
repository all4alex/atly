import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  void creatDirectChat(types.User otherUser, BuildContext context) async {
    emit(OnCreateChatLoading());
    try {
      final types.Room room =
          await FirebaseChatCore.instance.createRoom(otherUser);
      emit(OnCreateChatSuccess(room: room));
    } catch (e) {
      emit(OnCreateChatFailed());
    }
  }

  void createGroupChat(
      List<types.User> otherUsers, BuildContext context) async {
    emit(OnCreateChatLoading());
    try {
      final types.Room room = await FirebaseChatCore.instance
          .createGroupRoom(users: otherUsers, name: '');
      emit(OnCreateChatSuccess(room: room));
    } catch (e) {
      emit(OnCreateChatFailed());
    }
  }
}
