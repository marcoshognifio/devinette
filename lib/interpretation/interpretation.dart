import 'package:fa_gbassa/components/button.dart';
import 'package:fa_gbassa/interpretation/mode_chapelet.dart';
import 'package:fa_gbassa/interpretation/mode_signe.dart';
import 'package:flutter/material.dart';

class Interpretation extends StatefulWidget {
  Interpretation({super.key,required this.contextParent});
  BuildContext contextParent;

  @override
  State<Interpretation> createState() => _InterpretationState();
}

class _InterpretationState extends State<Interpretation> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonApp(text:'Mode Signe',
                       isWhite: true,
                       onTap:  (){Navigator.of(widget.contextParent).pushNamed('/modeSign');}
                    ),
                    ButtonApp(text:'Mode Chapelet',
                      isWhite: true,
                      onTap:  (){Navigator.of(widget.contextParent).pushNamed('/modeBeads');}
                    ),
                    ButtonApp(text: 'Rechercher',
                      isWhite: true,
                      onTap: (){
                        Map<String,dynamic> help = {
                          'buildContext':context,
                          'typeSearch':'text',
                          'list' :[]
                        };
                        Navigator.of(widget.contextParent).pushNamed('/modeSearch',arguments: help);
                        },),
                    ButtonApp(text:'Scanner',isWhite: true,onTap: (){},),
                  ],
                );
              }
          );
        }
    );
  }
}
