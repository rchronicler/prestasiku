import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prestasiku/src/components/show_snackbar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


class AuthRepository {
  AuthRepository(this._auth);
  final FirebaseAuth _auth;

  Stream<User?> authStateChanges() => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<void> signInAnonymously() {
    return _auth.signInAnonymously();
  }

  // * Sign in using email and password
  Future<User?> signInWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // show dialog
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text('Error!', style: TextStyle(color: Colors.red)),
            content: Text(e.code),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        });
    } catch (e) {
      print(e);
    }
    return null;
  }

  // * Sign up using email, password, full name, and phone number
  Future<User?> signUpWithEmailAndPassword(String email, String password, String fullName, String phoneNumber, BuildContext context) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // get uid
      final uid = userCredential.user!.uid;
      await userCredential.user!.updateDisplayName(fullName);

      // store to firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
      });

      return userCredential.user;

    } on FirebaseAuthException catch (e) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text('Error!', style: TextStyle(color: Colors.red)),
          content: Text(e.code),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      });
    } catch (e) {
      print(e);
    }
    return null;
  }

  // * Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

