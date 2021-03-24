import 'package:pfaMobile/screens/HomeScreen/home.dart';
import 'package:pfaMobile/routes.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce PFA Application',
      theme: themeData(),
      home: HomePage(),
      //routes: routes(),
      onGenerateRoute: routes(),
    );
  }
}
