enum EventInviteStatus {
  going,
  respond,
}

enum MessageType {
  direct,
  group,
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

extension MessageTypeExtension on MessageType {
  String get displayMessage {
    switch (this) {
      case MessageType.direct:
        return 'Message';
      case MessageType.group:
        return 'Group';
      default:
        return 'Message';
    }
  }
}
