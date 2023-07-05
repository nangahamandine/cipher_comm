// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthProvider {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   // Sign up with email and password
//   Future<UserCredential?> signUp(String email, String password) async {
//     try {
//       final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential;
//     } catch (e) {
//       print('Sign up error: $e');
//       return null;
//     }
//   }
//
//   // Sign in with email and password
//   Future<UserCredential?> signIn(String email, String password) async {
//     try {
//       final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential;
//     } catch (e) {
//       print('Sign in error: $e');
//       return null;
//     }
//   }
//
//   // Sign out
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }
//
//   // Get the current user
//   User? getCurrentUser() {
//     return _firebaseAuth.currentUser;
//   }
//
//   // Check if a user is signed in
//   bool isSignedIn() {
//     final User? currentUser = _firebaseAuth.currentUser;
//     return currentUser != null;
//   }
// }
