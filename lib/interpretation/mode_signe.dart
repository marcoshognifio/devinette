import 'dart:async';

import 'package:fa_gbassa/components/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/appbar.dart';
import '../components/data_class.dart';

class SigneMode extends StatefulWidget {
  const SigneMode({super.key});

  @override
  State<SigneMode> createState() => _SigneModeState();
}

class _SigneModeState extends State<SigneMode> {

  SigneDataNotifier notifier = SigneDataNotifier();

  int position = 0;
  late bool choose;

  @override
  void initState() {
    notifier.initialiseCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget('Mot Signe',context),
      body: Column(
          children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: 250,
                child: ChangeNotifierProvider(
                    create: (BuildContext context)=>notifier,
                    child: Consumer<SigneDataNotifier>(
                      builder: (context,notifier,_)=>
                          Column(
                            children:[
                              SizedBox(
                                width: 120,
                                child: Row(
                                  children: [
                                    notifier.cards[0],
                                    const Spacer(),
                                    notifier.cards[1]
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Row(
                                  children: [
                                    notifier.cards[2],
                                    const Spacer(),
                                    notifier.cards[3]
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Row(
                                  children: [
                                    notifier.cards[4],
                                    const Spacer(),
                                    notifier.cards[5]
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Row(
                                  children: [
                                    notifier.cards[6],
                                    const Spacer(),
                                    notifier.cards[7]
                                  ],
                                ),
                              ),
                            ],
                          ),
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset('assets/images/fa.png',width: 130,height: 15,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChooseSigneButton(line: false,onTap: (){

                      if(position < 8) {
                        notifier.itemChoose(position, 0) ;
                      }
                      position++;
                    }),
                    ChooseSigneButton(line: true,onTap: (){
                      if(position < 8) {
                        notifier.itemChoose(position, 1);
                      }
                      position++;
                    })
                  ],
                ),
              ),
              ButtonApp(text: 'Envoyer',isWhite: false,onTap:() async {

                Map<String,dynamic> help = {
                  'buildContext':context,
                  'typeSearch':'typeSign',
                  'list':notifier.signe
                };
                Navigator.pushNamed(context,'/modeSearch',arguments: help);
              }),
              ButtonApp(text: 'Supprimer',isWhite: true,onTap: (){
                notifier.initialiseCards();
                position = 0;
              },)
          ],
        ),
    );
  }

}

class ChooseSigneButton extends StatefulWidget {
  ChooseSigneButton({super.key,required this.line,required this.onTap});

  bool line;
  final VoidCallback onTap;

  @override
  State<ChooseSigneButton> createState() => _ChooseSigneButtonState();
}

class _ChooseSigneButtonState extends State<ChooseSigneButton> {

  bool isWhite = true;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 50,
      child: Card(
        shape:  RoundedRectangleBorder(
            borderRadius:  BorderRadius.circular(5),
            side: const BorderSide(
                color: Colors.black,
                width: 1
            )
        ),
        elevation: 5,
        child: ElevatedButton(

            style: ElevatedButton.styleFrom(
              backgroundColor: isWhite ? Colors.white:Colors.black, //Color(0xff2f52f6),
              padding:const  EdgeInsets.symmetric(vertical: 5),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onPressed: (){
              _handleClick();
              widget.onTap();
            },
            child: widget.line ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  width: 5.0,
                  height: 30.0,
                  color: isWhite ? Colors.black:Colors.white,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  width: 5.0,
                  height: 30.0,
                  color: isWhite ? Colors.black:Colors.white,
                )
              ],
            ):Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              width: 5.0,
              height: 30.0,
              color: isWhite ?Colors.black: Colors.white,
            )
        ),
      ),
    );
  }

  Future<void> _handleClick() async {

    setState(() {
      isWhite = isWhite ? false:true;
    });

    Timer(const Duration(milliseconds: 50), () {
      setState(() {
        isWhite = isWhite ? false:true;
      });
    });

  }
}

class SigneDataNotifier with ChangeNotifier {

  List<int> signe = [0,0,0,0,0,0,0,0];
  List<Widget>cards = [];

  @override
  void dispose() {
    super.dispose();
  }

  initialiseCards(){
    cards = [

      Container(
        width: 50,
        height: 50,
      ),
      Container(
        width: 50,
        height: 50,
      ),
      Container(
        width: 50,
        height: 50,
      ),

      Container(
        width: 50,
        height: 50,
      ),
      Container(
        width: 50,
        height: 50,
      ),
      Container(
        width: 50,
        height: 50,

      ),
      Container(
        width: 50,
        height: 50,
      ),
      Container(
        width: 50,
        height: 50,
      )
    ];
    notifyListeners();
  }

  itemChoose(position,int choose){
    signe[position] = choose;
    cards[position] = choose == 1 ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5,bottom: 5,right: 5),
            width: 2.0,
            height: 50.0,
            color:Colors.black,
          ),
          Container(
            margin: const EdgeInsets.only(top: 5,bottom: 5,left: 5),
            width: 2.0,
            height: 50.0,
            color: Colors.black,
          )
        ],
      ):Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: 2.0,
        height: 50.0,
        color: Colors.black,
      );
    notifyListeners();
  }
}



