import 'package:flutter/material.dart';
import 'package:prestasiku/auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _passwordVisible = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();

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
          buildTextField('Email', Icons.email, false, _emailController),
          SizedBox(height: 16),
          buildTextField('Password', Icons.lock, true, _passwordController),
          SizedBox(height: 16),
          buildTextField('Full Name', Icons.person, false, _fullNameController),
          SizedBox(height: 16),
          buildTextField(
              'Mobile Number', Icons.phone, false, _mobileNumberController),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Auth().createUserWithEmailAndPassword(
                fullName: _fullNameController.text,
                phoneNumber: _mobileNumberController.text,
                email: _emailController.text,
                password: _passwordController.text,
              );
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

  Widget buildTextField(String label, IconData icon, bool isPassword,
      TextEditingController controller) {
    return TextField(
      controller: controller,
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
