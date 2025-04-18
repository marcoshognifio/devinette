import 'package:flutter/material.dart';

import 'data_class.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(
              5.0,
              5.0,
            ), //Offset
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Color(0xff363636),
            offset: Offset(0.0, 0.0),
            blurRadius: 5.0,
            spreadRadius: 0.0,
          )
        ]
      ),
      child: AppBar(
        elevation: 10,
        backgroundColor: Colors.white,
        title: Center(child: Image.asset('assets/images/Logo3.png',width: 50,color: colorApp,)),
        leading:  Icon(Icons.sort,color: colorApp,size: 50,),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.account_circle_rounded,size: 50,color:Color(0xFF236718),),
            onPressed: () { },
          ),
        ],

      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
