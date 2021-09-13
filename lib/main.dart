import 'package:flutter/material.dart';
import 'package:sellandsign/constants/colors.dart';
import 'package:sellandsign/ui/home/home.dart';

import 'constants/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: AppColors.primaryBlack,
        scaffoldBackgroundColor: Colors.black
      ),
      home: Home(),
    );
  }
}
