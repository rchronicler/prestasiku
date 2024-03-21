import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prestasiku/src/features/authentication/providers/auth_provider.dart';

import '../../../components/loading_screen.dart';

// * Hidden password state
final hiddenPassword = StateProvider<bool>((ref) => true);

// * Loading state
final isLoading = StateProvider<bool>((ref) => false);

// * Text editing controllers
final emailControllerProvider = Provider((ref) => TextEditingController());
final passwordControllerProvider = Provider((ref) => TextEditingController());

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _emailController = ref.watch(emailControllerProvider);
    final _passwordController = ref.watch(passwordControllerProvider);
    final bool _isPasswordHidden = ref.watch(hiddenPassword);
    final bool _isItLoading = ref.watch(isLoading);
    final _auth = ref.watch(authRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9BC688),
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp, color: Color(0xFF165F22)),
          onPressed: () {
            GoRouter.of(context).go('/onboarding');
          },
        ),
        centerTitle: true,
        title: Text(
          'Masuk',
          style: TextStyle(
            color: Color(0xFF165F22), // 'Masuk' text color
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Color(0xFF9BC688), // Background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/image/logo.png',
                  height: 170,
                  fit: BoxFit.fill,
                ),
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.email, color: Color(0xFF165F23)), // Email icon
                  SizedBox(width: 8),
                  Text(
                    'Email',
                    style: TextStyle(
                      color: Color(0xFF165F23),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Masukan email',
                  filled: true,
                  fillColor: Color(0xFFE4E9D9),
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(17.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Icon(Icons.lock, color: Color(0xFF165F23)), // Password icon
                  SizedBox(width: 8),
                  Text(
                    'Password',
                    style: TextStyle(
                      color: Color(0xFF165F23),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                obscureText: _isPasswordHidden,
                decoration: InputDecoration(
                  hintText: 'Masukan kata sandi',
                  filled: true,
                  fillColor: Color(0xFFE4E9D9),
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(17.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(0xFF165F23),
                    ),
                    onPressed: () {
                      ref.read(hiddenPassword.notifier).state =
                          !_isPasswordHidden;
                    },
                  ),
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Implementasi forgot password
                  },
                  child: Text(
                    'Lupa Password?',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                  // login
                    ref.read(isLoading.notifier).state = true;
                    await _auth.signInWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                      context
                    );
                    // clear textfield
                    _emailController.clear();
                    _passwordController.clear();
                    ref.read(isLoading.notifier).state = false;
                  },
                  child: _isItLoading
                      // white loading indicator
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE4E9D9),
                          ),
                        ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF165F22), // Button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 120, vertical: 12),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: Text(
                  'atau masuk dengan',
                  style: TextStyle(color: Color(0xFF070707), fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2000.0),
                      ),
                      child: Icon(Icons.g_mobiledata, color: Color(0xFF165F23)),
                    ), // Google icon
                    onPressed: () {
                      // Implementasi Google Sign-In
                    },
                  ),
                  IconButton(
                    icon: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2000.0),
                      ),
                      child: Icon(Icons.facebook, color: Color(0xFF165F23)),
                    ), // Facebook icon
                    onPressed: () {
                      // Implementasi Facebook Sign-In
                    },
                  ),
                ],
              ),
              SizedBox(height: 24),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Belum punya akun? ',
                        style: TextStyle(
                          color: Color(0xFF070707),
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: 'Daftar',
                        style: TextStyle(
                          color: Color(0xFF165F23),
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            GoRouter.of(context).go("/signup");
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
