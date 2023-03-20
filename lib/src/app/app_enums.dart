enum EventInviteStatus {
  going,
  respond,
}

extension EventInviteStatusExtension on EventInviteStatus {
  String get displayMessage {
    switch (this) {
      case EventInviteStatus.going:
        return 'Going';
      case EventInviteStatus.respond:
        return 'Respond';
      default:
        return 'Message';
    }
  }
}
