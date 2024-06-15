import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Required for kDebugMode
import 'package:nestify_app/screens/HomeScreen.dart';
import 'package:nestify_app/screens/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For local storage

// Placeholder class for API integration
class ApiService {
  static Future<void> syncUserData(Map<String, dynamic> userData) async {
    // Simulate API call to synchronize user data
    await Future.delayed(const Duration(seconds: 1));
    print("user: $userData");
  }
}

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (value == null || value.isEmpty) {
      return 'Enter a valid email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    final passwordRegex = RegExp(
        r'^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).{8,}$');
    if (value == null || value.isEmpty) {
      return 'Enter a valid password';
    } else if (!passwordRegex.hasMatch(value)) {
      return 'Enter a valid password';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    final phoneRegex =
    RegExp(r'^(\+91[\-\s]?)?[0]?(91)?(\(\+91\))?[7896]\d{9}$');
    if (value == null || value.isEmpty) {
      return 'Enter a valid phone number';
    } else if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  void _validateAndSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (kDebugMode) {
        print('Form submitted successfully');
      }

      // Store user data locally
      Map<String, dynamic> userData = {
        'email': emailController.text,
        'password': passwordController.text,
        'phone': phoneController.text,
        'address': addressController.text,
      };
      await _storeUserDataLocally(userData);

      // Synchronize data with API
      await ApiService.syncUserData(userData);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      if (kDebugMode) {
        print('Form not submitted');
      }
    }
  }

  Future<void> _storeUserDataLocally(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', userData['email']);
    prefs.setString('password', userData['password']);
    prefs.setString('phone', userData['phone']);
    prefs.setString('address', userData['address']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Personal details',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: emailController,
                  label: 'Email',
                  icon: Icons.email,
                  validator: validateEmail,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: passwordController,
                  label: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                  validator: validatePassword,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter confirm password';
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: phoneController,
                  label: 'Phone',
                  icon: Icons.phone,
                  validator: validatePhoneNumber,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: addressController,
                  label: 'Address (Optional)',
                  icon: Icons.home,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => _validateAndSubmit(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 200),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignInScreen()),
                          );
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUpScreen(),
    theme: ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  ));
}
