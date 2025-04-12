import 'package:flutter/material.dart';

const String url = "http://127.0.0.1:8000";

String token="";


List<String> listRoutes = [];

TextStyle textWelcome = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25,
    color: Colors.white,
    letterSpacing: 2
);

Color colorApp = const Color(0xFF1B4F9D);
List<Color> listColor = [const Color(0xFF2E82B7), const Color(0xFF12642E)];
TextStyle textWelcomeUnder = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 17,
    letterSpacing: 2,
    color: Colors.white.withOpacity(0.7)
);


class CounterPage {
  int value;
  CounterPage(this.value);
}

class ChooseCori {
  int x;
  int y;
  ChooseCori(this.x,this.y);
}

