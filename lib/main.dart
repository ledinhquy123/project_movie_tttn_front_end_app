import 'package:app_movie/views/screens/introduction_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MovieApp()
  );
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w700
          ),

          bodyLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
          ),

          bodyMedium: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
          ),

          bodySmall: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
          ),
        )
      ),
      home: const IntroductionScreen(),
    );
  }
}