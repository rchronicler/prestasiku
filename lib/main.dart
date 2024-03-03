import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF9BC688), // Scaffold background color
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xFF4CAF50),
            child: Text('Logo'),
          ),
          SizedBox(height: 48),
          buildTextField('Email', Icons.email, false),
          SizedBox(height: 16),
          buildTextField('Password', Icons.lock, true),
          SizedBox(height: 16),
          buildTextField('Full Name', Icons.person, false),
          SizedBox(height: 16),
          buildTextField('Mobile Number', Icons.phone, false),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Sign up logic
            },
            child: Text('Sign Up'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(vertical: 14),
              backgroundColor: Color(0xFF4CAF50), // Button color
            ),
          ),
          SizedBox(height: 16),
          Text(
            'By continuing, you agree to Terms of Use and Privacy Policy.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, IconData icon, bool isPassword) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : null,
      ),
      obscureText: isPassword && !_passwordVisible,
      keyboardType:
          isPassword ? TextInputType.text : TextInputType.emailAddress,
    );
  }
}
