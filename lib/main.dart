import 'package:flutter/material.dart';
import 'package:yellow_class/Home.dart';
import 'Login_page.dart';
import 'Home.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title : "Login Page",
      theme: new ThemeData( 
        primarySwatch: Colors.red,
      ),
      home : new Video(),
    );
  }
}
