import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/appbar.dart';
import '../components/button.dart';


class Beads extends StatefulWidget {
  const Beads({super.key});

  @override
  State<Beads> createState() => _BeadsState();
}

class _BeadsState extends State<Beads> {

  SigneDataNotifier notifier = SigneDataNotifier();

  int position = 0;

  @override
  void initState() {
    notifier.initialiseCards();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget('Mode Chapelet',context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const  EdgeInsets.symmetric(vertical:  20),
            height: 240,
            child: ChangeNotifierProvider(
                create: (BuildContext context)=>notifier,
                child: Consumer<SigneDataNotifier>(
                  builder: (context,notifier,_)=>
                      Column(
                        children:[
                          Container(
                            margin: const  EdgeInsets.symmetric(vertical:  15),
                            width: 120,
                            height: 30,
                            child: Row(
                              children: [
                                notifier.cards[0],
                                const Spacer(),
                                notifier.cards[1]
                              ],
                            ),
                          ),
                          Container(
                            margin: const  EdgeInsets.symmetric(vertical:  15),
                            width: 120,
                            height: 30,
                            child: Row(
                              children: [
                                notifier.cards[2],
                                const Spacer(),
                                notifier.cards[3]
                              ],
                            ),
                          ),
                          Container(
                            margin: const  EdgeInsets.symmetric(vertical:  15),
                            width: 120,
                            height: 30,
                            child: Row(
                              children: [
                                notifier.cards[4],
                                const Spacer(),
                                notifier.cards[5]
                              ],
                            ),
                          ),
                          Container(
                            margin: const  EdgeInsets.symmetric(vertical:  15),
                            width: 120,
                            height: 30,
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
          Image.asset('assets/images/fa.png',width: 130,height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChooseCowriesButton(circle: true, onTap: () {

                  if(position < 8) {
                    notifier.itemChoose(position, 0) ;
                  }
                  position++;
                }),
                ChooseCowriesButton(circle: false, onTap: (){
                  if(position < 8) {
                    notifier.itemChoose(position, 1);
                  }
                  position++;
                })
              ],
            ),
          ),
          ButtonApp(text: 'Envoyer',isWhite: false,onTap: (){
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
          },),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }
}

class ChooseCowriesButton extends StatefulWidget {
  ChooseCowriesButton({super.key,required this.circle,required this.onTap});
  bool circle;
  final VoidCallback onTap;

  @override
  State<ChooseCowriesButton> createState() => _ChooseCowriesButtonState();
}

class _ChooseCowriesButtonState extends State<ChooseCowriesButton> {


  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 40,
      child: Card(
        color: Colors.white,
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
              backgroundColor: Colors.white, //Color(0xff2f52f6),
              padding:const  EdgeInsets.symmetric(vertical: 10),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onPressed: (){

              widget.onTap();
            },
            child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color:  widget.circle ? Colors.white:Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                )
        ),
      ),
    );
  }
}

class SigneDataNotifier with ChangeNotifier {

  List<int> signe = [0,0,0,0,0,0,0,0];
  List<Widget>cards = [];

  @override
  void dispose() {
    super.dispose();
    print("Disposer vraiment");
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
    cards[position] = choose == 1 ? Container(
      width: 25.0,
      height: 25.0,
      decoration: BoxDecoration(
        color:  Colors.black,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
    ):Container(
      width: 25.0,
      height: 25.0,
      decoration: BoxDecoration(
        color:  Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
    );
    notifyListeners();
  }
}

