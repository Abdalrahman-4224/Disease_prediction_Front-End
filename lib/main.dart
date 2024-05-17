import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Notok_Result_Screen.dart';
import 'Start_Screen.dart';
import 'Ok_Rsult_Screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();  // Set your HTTP overrides
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: StartPage(),
      ),
    );
  }
}

// Custom HttpOverrides class to accept self-signed certificates
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
