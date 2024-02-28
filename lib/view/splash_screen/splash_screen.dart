import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_app/view/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SizedBox(
        height: 100,
        width: 100,
        child: Image(
          image: NetworkImage(
              'https://play-lh.googleusercontent.com/IDOtRhsZLSG3EFxWxmWREMPa42_SNQvl9-x4FBu5dn9aJMjpVtMx_GoNdnQwEIp_7gsV'),
          fit: BoxFit.cover,
        ),
      )),
    );
  }
}
