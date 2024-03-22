import 'dart:async';

import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/views/screens/get_started_screen.dart';
import 'package:flutter/material.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const GetStartedScreen())
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [ primaryMain1, primaryMain2 ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
          ),
          color: Colors.grey.withOpacity(.7),
        ),
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}