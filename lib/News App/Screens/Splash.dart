import 'dart:async';

import 'package:flutter/material.dart';


import 'login.dart';

class SplashScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const SplashScreen(
      {Key? key, required this.toggleTheme, required this.isDarkMode})
      : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHomePage();
  }

  void _navigateToHomePage() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Loginpage(toggleTheme: widget.toggleTheme, isDarkMode: widget.isDarkMode)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 100.0),
              duration: const Duration(seconds: 3),
              builder: (context, double radius, child) {
                return CircleAvatar(
                  radius: radius,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/icons/app_logo.png',
                      width: radius * 2,
                      height: radius * 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'H&N News',
              style: TextStyle(fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}