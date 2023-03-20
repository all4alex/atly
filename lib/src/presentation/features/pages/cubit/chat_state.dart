part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class OnCreateChatLoading extends ChatState {}

class OnCreateChatSuccess extends ChatState {
  final types.Room room;

  OnCreateChatSuccess({required this.room});
}

class OnCreateChatFailed extends ChatState {}
