import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_budget_ui/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.green,
              statusBarIconBrightness: Brightness.light
          ),
        ),
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}
