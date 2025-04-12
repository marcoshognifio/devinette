import 'package:fa_gbassa/components/data_class.dart';
import 'package:flutter/material.dart';

class Consultation extends StatefulWidget {
  const Consultation({super.key});

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  List<ChooseCori> data = [
    ChooseCori(0,0),
    ChooseCori(0,0),
    ChooseCori(0,0),
    ChooseCori(0,0),
    ChooseCori(0,0),
    ChooseCori(0,0),
    ChooseCori(0,0),
    ChooseCori(0,0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 600,
          height: 600,
          child: content(),
        ),
      ),
    );
  }

  Widget content(){

    return Row(
      children: [
        Coris(position: 0, choose: data[0] ),
        Coris(position: 1, choose: data[0] ),
        Coris(position: 2, choose: data[0] ),
        Coris(position: 3, choose: data[0] ),
        Coris(position: 4, choose: data[0] ),
        Coris(position: 5, choose: data[0] ),
        Coris(position: 6, choose: data[0] ),
        Coris(position: 7, choose: data[0] ),

      ],
    );
  }
}




class Coris extends StatelessWidget {
  Coris({super.key,required this.position,required this.choose});
  int position;
  ChooseCori choose;
  Color colorX = Colors.yellow;
  Color colorY = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      child: Row(
        children: [
          Container(
            width: 30,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: colorX
            ),
            child: ElevatedButton(
              onPressed: () {
                choose.x  = choose.x == 0 ?1:0;

              },
              child: null,),
          ),

          Container(
            width: 30,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: colorY
            ),
            child: ElevatedButton(
              onPressed: () {
                choose.y  = choose.y == 0 ?1:0;

              },
              child: null,),

          ),
        ],
      ),
    );
  }
}

