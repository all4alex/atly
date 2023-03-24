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

enum MessageType {
  direct,
  group,
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
