import 'package:flutter/material.dart';
import 'package:fyp/JobsPosts/postscreen.dart';
import 'package:fyp/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      home:splashScreen( ) ,);
  }
}