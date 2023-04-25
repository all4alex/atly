class EventModel {
  String? eventId;
  String? title;
  String? imageUrl;
  String? description;
  DateTime? startTime;
  DateTime? endTime;
  String? locationName;
  String? address;
  String? organizer;
  List<String>? attendees;
  DateTime? createdAt;
  DateTime? updatedAt;

  EventModel({
    this.eventId,
    this.title,
    this.imageUrl,
    this.description,
    this.startTime,
    this.endTime,
    this.locationName,
    this.address,
    this.organizer,
    this.attendees,
    this.createdAt,
    this.updatedAt,
  });

  EventModel.fromMap(Map<String, dynamic> map) {
    eventId = map['eventId'];
    title = map['title'];
    imageUrl = map['imageUrl'];
    description = map['description'];
    startTime = map['startTime'].toDate();
    endTime = map['endTime'].toDate();
    locationName = map['locationName'];
    address = map['address'];
    organizer = map['organizer'];
    attendees = List<String>.from(map['attendees'] ?? []);
    createdAt = map['createdAt'].toDate();
    updatedAt = map['updatedAt'].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'locationName': locationName,
      'address': address,
      'organizer': organizer,
      'attendees': attendees,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
