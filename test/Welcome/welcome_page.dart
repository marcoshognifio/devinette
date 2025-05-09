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
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.fill)
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 200),
            child: Image.asset('assets/images/Logo3.png',width: 200,),
          ),
        ),
      ),
    );
  }
}


