import 'package:calc/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de Taxas',
      theme: ThemeData(primaryColor: Color(0xFF14142B)),
      home: FirstRoute(),
    );
  }
}
