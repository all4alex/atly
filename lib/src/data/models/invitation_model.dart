class InvitationModel {
  String? invitationId;
  String? eventId;
  String? sender;
  String? recipient;
  String? status;
  DateTime? sentAt;

  InvitationModel({
    this.invitationId,
    this.eventId,
    this.sender,
    this.recipient,
    this.status,
    this.sentAt,
  });

  InvitationModel.fromMap(Map<String, dynamic> map) {
    invitationId = map['invitationId'];
    eventId = map['eventId'];
    sender = map['sender'];
    recipient = map['recipient'];
    status = map['status'];
    sentAt = map['sentAt'].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      'invitationId': invitationId,
      'eventId': eventId,
      'sender': sender,
      'recipient': recipient,
      'status': status,
      'sentAt': sentAt,
    };
  }
}
