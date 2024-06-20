import 'package:flutter/material.dart';
import 'package:nestify_app/screens/SignIn.dart';
import 'package:nestify_app/screens/SignUp.dart';
import 'package:nestify_app/screens/HomeScreen.dart'; // Import the HomeScreen

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/signin_signup 2.png'), // Ensure this path is correct
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 7),
                const Text(
                  'Stylish \n furniture for \n your home',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                const Text(
                  'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                const Spacer(flex: 40),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignInScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // background color
                          foregroundColor: Colors.black, // text color
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // rounded corners
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        child: const Text('Sign in'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white, // text color
                          side: const BorderSide(color: Colors.white), // border color
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // rounded corners
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18, // font size
                          ),
                        ),
                        child: const Text('Sign up'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16), // Add some space between the buttons
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, // text color
                  ),
                  child: const Text(
                    'Get started as a guest',
                    style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.underline, // underline text
                    ),
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
