// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class MessageProvider {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Get messages for a specific chat
//   Stream<QuerySnapshot> getMessages(String chatId) {
//     return _firestore
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages')
//         .orderBy('timestamp', descending: true)
//         .snapshots();
//   }
//
//   // Send a message to a chat
//   Future<void> sendMessage(String chatId, String senderId, String text) async {
//     final messageData = {
//       'senderId': senderId,
//       'text': text,
//       'timestamp': DateTime.now().millisecondsSinceEpoch,
//     };
//
//     await _firestore
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages')
//         .add(messageData);
//   }
// }
