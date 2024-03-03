import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prestasiku/auth_wrapper.dart';
import 'package:prestasiku/firebase_options.dart';
import 'package:prestasiku/pages/signup_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          color: Color(0xFF4CAF50), // AppBar background color
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home: AuthWrapper(),
    );
  }
}
