import 'package:flutter/material.dart';
import 'package:information_technology/pages/main_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.grey.shade200,
      ),
      debugShowCheckedModeBanner: false,
      home: MainPages(),
    );
  }
}
