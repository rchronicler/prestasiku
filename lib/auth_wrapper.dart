import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prestasiku/pages/home_page.dart';
import 'package:prestasiku/pages/signup_page.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print('Auth state changed: $snapshot'); // Debug message
          if (snapshot.hasData) {
            print('User authenticated: ${snapshot.data}'); // Debug message
            return HomePage();
          } else {
            return SignUpPage();
          }
        });
  }
}
