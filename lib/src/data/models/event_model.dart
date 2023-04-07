class EventModel {
  String? eventId;
  String? title;
  String? description;
  DateTime? startTime;
  DateTime? endTime;
  String? location;
  String? organizer;
  List<String>? attendees;
  DateTime? createdAt;
  DateTime? updatedAt;

  EventModel({
    this.eventId,
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.location,
    this.organizer,
    this.attendees,
    this.createdAt,
    this.updatedAt,
  });

  EventModel.fromMap(Map<String, dynamic> map) {
    eventId = map['eventId'];
    title = map['title'];
    description = map['description'];
    startTime = map['startTime'].toDate();
    endTime = map['endTime'].toDate();
    location = map['location'];
    organizer = map['organizer'];
    attendees = List<String>.from(map['attendees'] ?? []);
    createdAt = map['createdAt'].toDate();
    updatedAt = map['updatedAt'].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'title': title,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'location': location,
      'organizer': organizer,
      'attendees': attendees,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
