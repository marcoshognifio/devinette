import 'dart:ffi';

import 'package:fa_gbassa/alphabet/detail_alphabet.dart';
import 'package:fa_gbassa/divinity/detail_divinity.dart';
import 'package:fa_gbassa/interpretation/mode_chapelet.dart';
import 'package:fa_gbassa/interpretation/mode_recherche.dart';
import 'package:fa_gbassa/interpretation/mode_signe.dart';
import 'package:fa_gbassa/user/change_password.dart';
import 'package:fa_gbassa/user/forget_password.dart';
import 'package:fa_gbassa/user/infos_profit.dart';
import 'package:fa_gbassa/user/inscription.dart';
import 'package:fa_gbassa/user/login.dart';
import 'package:fa_gbassa/user/pay_page.dart';
import 'package:fa_gbassa/user/profit_user.dart';
import 'package:fa_gbassa/user/subscription.dart';
import 'package:fa_gbassa/user/update_password.dart';
import 'package:fa_gbassa/user/user_slide_widgets.dart';
import 'package:fa_gbassa/user/verify_email.dart';
import 'package:flutter/material.dart';
import 'Welcome/welcome_page.dart';
import 'Welcome/welcome_slide.dart';
import 'components/data_class.dart';
import 'interpretation/detail_signe.dart';


void main() {
  runApp(const MyApp() );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Finance True App',
      onGenerateRoute:(settings)=>RouteGenerator.generatorRoute(settings),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
    );
  }
}

class RouteGenerator {
  static Route<dynamic> ?generatorRoute(RouteSettings settings) {
    switch (settings.name) {

      case '/home':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>const WelcomePage(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/login':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>const LoginPage(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/inscription':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>const InscriptionPage(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/forgetPassword':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>const ForgetPassword(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/verifyEmail':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>VerifyEmail(data: settings.arguments as Map<String,dynamic>),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/updatePassword':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>const UpdatePassword(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/infoDivinity':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> DetailDivinity(divinity: settings.arguments as Map<String,dynamic>),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/infoSigne':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> DetailSign(sign: settings.arguments as Map<String,dynamic>),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/infoAlphabet':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> DetailAlphabet(alphabet: settings.arguments as Map<String,dynamic>),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/welcomeSlide':
        return PageRouteBuilder(

            pageBuilder: (context, animation, secondAnimation) =>
                const WelcomeSlide(),
            transitionsBuilder: (context, animation, secondAnimation, child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.ease);
              return FadeTransition(opacity: animation, child: child);
            }
        );

      case '/infoProfit':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> const InfoProfit(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/profileUser':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> ProfitUser(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/modeSign':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> const SigneMode(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/modeBeads':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> const Beads(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/modeSearch':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation){
              Map<String,dynamic> help = settings.arguments as Map<String,dynamic> ;
              return SearchMode(contextParent: help['buildContext'], typeSearch: help['typeSearch'], list: help['list']);
            },
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/userSlide':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=> UserSlideWidget(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/abonnement':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> const Subscription(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/payPage':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> const PayPage(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/changePassword':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> const ChangePassword(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });


    }
    return null;
  }
}

