// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class GroupProvider {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Create a new group in Firestore
//   Future<void> createGroup(String groupId, String groupName, List<String> memberIds) async {
//     final groupData = {
//       'groupId': groupId,
//       'groupName': groupName,
//       'memberIds': memberIds,
//     };
//
//     await _firestore.collection('groups').doc(groupId).set(groupData);
//   }
//
//   // Get a list of groups for a specific user
//   Future<List<Map<String, dynamic>>> getGroupsForUser(String userId) async {
//     final querySnapshot = await _firestore.collection('groups').where('memberIds', arrayContains: userId).get();
//     return querySnapshot.docs.map((doc) => doc.data()).toList();
//   }
// }
