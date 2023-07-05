// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class CallProvider {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Create a call document in Firestore
//   Future<void> createCall(String callId, String callerId, String receiverId, String callType) async {
//     final callData = {
//       'callId': callId,
//       'callerId': callerId,
//       'receiverId': receiverId,
//       'callType': callType,
//       'timestamp': DateTime.now().millisecondsSinceEpoch,
//     };
//
//     await _firestore.collection('calls').doc(callId).set(callData);
//   }
//
//   // End a call and update the call document in Firestore
//   Future<void> endCall(String callId) async {
//     final callData = {
//       'ended': true,
//       'endTime': DateTime.now().millisecondsSinceEpoch,
//     };
//
//     await _firestore.collection('calls').doc(callId).update(callData);
//   }
// }
