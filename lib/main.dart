import 'package:flutter/material.dart';
import 'package:phonesubscriptions/colors/colors.dart';
import 'package:phonesubscriptions/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp() : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: IColors.steel
      ),
      home: HomePage(),
    );
  }
}

