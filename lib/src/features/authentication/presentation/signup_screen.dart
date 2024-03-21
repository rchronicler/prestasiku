import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prestasiku/src/features/authentication/providers/auth_provider.dart';

// * Hidden password state
final hiddenPassword = StateProvider<bool>((ref) => true);

// * Loading state
final isLoading = StateProvider<bool>((ref) => false);

// * Text editing controllers
final emailControllerProvider = Provider((ref) => TextEditingController());
final passwordControllerProvider = Provider((ref) => TextEditingController());
final fullNameControllerProvider = Provider((ref) => TextEditingController());
final phoneNumberControllerProvider =
    Provider((ref) => TextEditingController());

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _emailController = ref.watch(emailControllerProvider);
    final _passwordController = ref.watch(passwordControllerProvider);
    final _fullNameController = ref.watch(fullNameControllerProvider);
    final _phoneNumberController = ref.watch(phoneNumberControllerProvider);

    final bool isPasswordHidden = ref.watch(hiddenPassword);
    final bool isItLoading = ref.watch(isLoading);
    final _auth = ref.watch(authRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9BC688),
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp, color: Color(0xFF165F22)),
          onPressed: () {
            GoRouter.of(context).go('/signin');
          },
        ),
        centerTitle: true,
        title: Text(
          'Daftar',
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
              SizedBox(height: 8),
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
                obscureText: isPasswordHidden,
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
                      isPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(0xFF165F23),
                    ),
                    onPressed: () {
                      ref.read(hiddenPassword.notifier).state =
                          !isPasswordHidden;
                    },
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Icon(Icons.person, color: Color(0xFF165F23)), // Email icon
                  SizedBox(width: 8),
                  Text(
                    'Nama Lengkap',
                    style: TextStyle(
                      color: Color(0xFF165F23),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  hintText: 'Masukan nama lengkap',
                  filled: true,
                  fillColor: Color(0xFFE4E9D9),
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(17.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Icon(Icons.phone, color: Color(0xFF165F23)), // Email icon
                  SizedBox(width: 8),
                  Text(
                    'Nomor Telepon',
                    style: TextStyle(
                      color: Color(0xFF165F23),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Masukan nomor telepon',
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
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Sign up
                    ref.read(isLoading.notifier).state = true;
                    final future = _auth.signUpWithEmailAndPassword(
                        _emailController.text,
                        _passwordController.text,
                        _fullNameController.text,
                        _phoneNumberController.text,
                        context
                    );

                    final user = await future;

                    if (user != null) {
                      _emailController.clear();
                      _passwordController.clear();
                      _fullNameController.clear();
                      _phoneNumberController.clear();
                      GoRouter.of(context).go('/home');
                    }
                    ref.read(isLoading.notifier).state = false;
                  },
                  child: isItLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Daftar',
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
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Center(
                  child: Text(
                    'By continuing, you agree to our Terms of Use and Privacy Policy',
                    style: TextStyle(color: Color(0xFF070707), fontSize: 16),
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
