import 'package:flutter/material.dart';
import 'package:nestify_app/MyApp.dart';
import 'package:nestify_app/screens/HomeScreen.dart';
import 'package:nestify_app/screens/SaleUpPage.dart';

void main() {
  runApp(MaterialApp(
      routes: {
        '/Home': (context) => HomeScreen(),
        '/SaleUpPage': (context) => SaleUpPage(),
      },
      debugShowCheckedModeBanner: false,
  home: MyApp()
  ));
}