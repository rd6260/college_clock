import 'package:college_clock/screens/home_screen.dart';
import 'package:college_clock/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreenGate extends StatelessWidget {
  const FirstScreenGate({super.key});

  Future<bool> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    return isFirstTime;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkFirstSeen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Icon(Icons.biotech_rounded);
        } else {
          if (snapshot.data == true) {
            return OnBoardingScreen();
          } else {
            return HomeScreen();
          }
        }
      },
    );
  }
}
