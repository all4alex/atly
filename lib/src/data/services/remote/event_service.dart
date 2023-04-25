import 'package:atly/src/data/models/event_model.dart';
import 'package:atly/src/data/models/invitation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Event
  Future<void> addEvent(EventModel event) async {
    return await _db.collection('events').doc(event.eventId).set(event.toMap());
  }

  Future<EventModel> getEvent(String eventId) async {
    DocumentSnapshot doc = await _db.collection('events').doc(eventId).get();
    return EventModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  // Invitation
  Future<void> addInvitation(InvitationModel invitation) async {
    return await _db
        .collection('invitations')
        .doc(invitation.invitationId)
        .set(invitation.toMap());
  }

  Future<InvitationModel> getInvitation(String invitationId) async {
    DocumentSnapshot doc =
        await _db.collection('invitations').doc(invitationId).get();
    return InvitationModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  // Query Examples
  Stream<List<EventModel>> getEventsByOrganizer(String organizerId) {
    return _db
        .collection('events')
        .where('organizer', isEqualTo: organizerId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
                (doc) => EventModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<InvitationModel>> getInvitationsByRecipient(
      String recipientEmail) {
    return _db
        .collection('invitations')
        .where('recipient', isEqualTo: recipientEmail)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                InvitationModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<EventModel>> getEventsByDateRange(DateTime start, DateTime end) {
    return _db
        .collection('events')
        .where('startTime', isGreaterThanOrEqualTo: start)
        .where('endTime', isLessThanOrEqualTo: end)
        .orderBy('startTime')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
                (doc) => EventModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<EventModel>> getEventsByAttendee(String userId) {
    return _db
        .collection('events')
        .where('attendees', arrayContains: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
                (doc) => EventModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<InvitationModel>> getInvitationsByStatus(String status) {
    return _db
        .collection('invitations')
        .where('status', isEqualTo: status)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                InvitationModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<void> updateEvent(EventModel event) async {
    return await _db
        .collection('events')
        .doc(event.eventId)
        .update(event.toMap());
  }

  Future<void> deleteEvent(String eventId) async {
    return await _db.collection('events').doc(eventId).delete();
  }

  Future<void> updateInvitationStatus(
      String invitationId, String status) async {
    return await _db
        .collection('invitations')
        .doc(invitationId)
        .update({'status': status});
  }
}
