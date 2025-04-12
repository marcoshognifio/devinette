 import 'dart:async';

import 'package:flutter/material.dart';
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer=Timer.periodic( const Duration(seconds: 5),(timer){
      setState(() {

        Navigator.pushNamed(context, '/welcomeSlide');
      });
      setState(() {
        timer.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.fill)
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: Image.asset('assets/images/fagbassa.png',width: 200,),
          ),
        ),
      ),
    );
  }
}


