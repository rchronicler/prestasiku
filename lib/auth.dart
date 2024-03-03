import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword(
      {required fullName,
      required phoneNumber,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user's unique ID
      String userId = userCredential.user!.uid;

      // Update the user's display name
      await userCredential.user!.updateDisplayName(fullName);

      // Create a document in Firestore for the user profile
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        // You can add more fields as needed
      });

      print('User created successfully');
    } catch (e) {
      print('Error creating user: $e');
    }
  }
}
