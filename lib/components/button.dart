import 'package:flutter/material.dart';

import 'data_class.dart';

//ignore: must_be_immutable
class ButtonWelcome extends StatelessWidget {
  ButtonWelcome({super.key, required this.text, required this.chooseType, required this.onTap});
   final String text;
   final VoidCallback onTap;
   final bool chooseType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        child: ElevatedButton(

          style: ElevatedButton.styleFrom(
            backgroundColor: chooseType ? Colors.black : Colors.white, //Color(0xff2f52f6),
            padding:const  EdgeInsets.only(top: 15, bottom: 15),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            side: chooseType ? null: const BorderSide(color:Colors.black)
          ),
          onPressed: onTap,
          child: Text(text,style: TextStyle(
              fontFamily: 'Roboto-Regular',
              color: chooseType ? Colors.white: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              wordSpacing: 3,
              letterSpacing: 1)
          ),
        ),
    );
  }
}

class Button extends StatelessWidget {
  Button({super.key, required this.text, required this.width, required this.onTap});
  final String text;
  final double width;
  final VoidCallback onTap;

  TextStyle textStyle=const TextStyle(
      fontFamily: 'Roboto-Regular',
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      wordSpacing: 3,
      letterSpacing: 1);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth*0.8,
      height: screenHeight*0.06,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, //Color(0xff2f52f6),
                padding:const  EdgeInsets.only(top: 10, bottom: 10),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: onTap,
              child: Text(text,style: textStyle),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonIcon extends StatelessWidget {
  ButtonIcon({super.key, required this.onTap,required this.icon,required this.size});
  final VoidCallback onTap;
  Icon icon;
  double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(
          colors: listColor,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: IconButton(
          color: Colors.transparent,
          icon:icon ,
          onPressed: onTap
      ),
    );
  }
}

class ButtonApp extends StatelessWidget {
  const ButtonApp({super.key,required this.text,required this.isWhite,required this.onTap});
  final String text;
  final VoidCallback onTap;
  final  isWhite;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape:  RoundedRectangleBorder(
          borderRadius:  BorderRadius.circular(5),
          side: const BorderSide(
              color: Colors.black,
              width: 1
          )
      ),
      elevation: 5,
      child: SizedBox(
        width: 300,
        height: 50,
        child: ElevatedButton(

          style: ElevatedButton.styleFrom(
            backgroundColor: isWhite ? Colors.white:Colors.black, //Color(0xff2f52f6),
            padding:const  EdgeInsets.symmetric(vertical: 10),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onPressed: onTap,
          child: Text(text,style: TextStyle(fontFamily: "Roboto-Regular",color:isWhite ? Colors.black:Colors.white,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
