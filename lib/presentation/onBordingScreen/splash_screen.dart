import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_one_maybe_clean_architecture/presentation/onBordingScreen/PageView.dart';

class SpllashScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SpllashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ViewPage())));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Image.asset(
          'assets/images/logo.jpg',
          width: double.infinity,
          fit: BoxFit.fill,
          height: double.infinity,
        ),
      ),
    );
  }
}
