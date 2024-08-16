import 'package:fa_gbassa/components/data_class.dart';
import 'package:flutter/material.dart';

class Consultation extends StatefulWidget {
  const Consultation({super.key});

  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  List<List> data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 600,
          height: 600,
          child: ,
        ),
      ),
    );
  }
}


Widget content(){

  Widget a = Row(
    children: [
      Coris(position: 0, value: 1),
      Coris(position: 1, value: )
    ],
  )
}

class Coris extends StatelessWidget {
  Coris({super.key,required this.position,required this.value});
  int position;
  int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: colorApp
      ),
      child: ElevatedButton(
        onPressed: () {
          value  = value == 0 ?1:0;
        },
        child: null,),

    );
  }
}

