// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationCountUpdated extends NotificationState {
  final int count;
  NotificationCountUpdated({required this.count});

  NotificationCountUpdated copyWith({
    int? count,
  }) {
    return NotificationCountUpdated(
      count: count ?? this.count,
    );
  }
}
