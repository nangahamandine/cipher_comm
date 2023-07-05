// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class MeetingProvider {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Create a new meeting in Firestore
//   Future<void> createMeeting(String meetingId, String title, String description, DateTime startTime, DateTime endTime, List<String> attendeeIds) async {
//     final meetingData = {
//       'meetingId': meetingId,
//       'title': title,
//       'description': description,
//       'startTime': startTime,
//       'endTime': endTime,
//       'attendeeIds': attendeeIds,
//     };
//
//     await _firestore.collection('meetings').doc(meetingId).set(meetingData);
//   }
//
//   // Get a list of meetings for a specific user
//   Future<List<Map<String, dynamic>>> getMeetingsForUser(String userId) async {
//     final querySnapshot = await _firestore.collection('meetings').where('attendeeIds', arrayContains: userId).get();
//     return querySnapshot.docs.map((doc) => doc.data()).toList();
//   }
// }
