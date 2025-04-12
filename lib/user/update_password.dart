import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/components.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          decoration: const BoxDecoration(
            image:DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.fill),

          ),
          child: Stack(
            children: [
              Center( child: content(),),
            ],
          )
      ),
    );

  }

  Widget content(){

    return SizedBox(
      width: 320,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top:50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nouveau Mot de Passe",
                    style: TextStyle(
                      fontFamily: 'Roboto-Regular',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Text("Entrer un nouveau Mot de Passe",
                      style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          fontSize: 12,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
          ,
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Form(
                key: formKey,
                child: Column(
                  children: [

                    EntryField(
                      text: "Nouveau Mot de Passe",
                      type: "password",
                      express: RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                      control: emailController,
                      required: true,
                      error: "",
                    ),
                EntryField(
                  text: "Confirmer Mot de Pass",
                  type: "password",
                  express: RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                  control: emailController,
                  required: true,
                  error: "",
                ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Button(text: "Envoyer", onTap: () {  },width: 350,),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Vous vous rappelez du Mot de Passe ?",style: TextStyle(fontFamily: 'Roboto-Regular',fontSize: 12),),
                          TextButton(
                              onPressed: () {Navigator.pushNamed(context, '/login');},
                              child: const Text("Se Connecter",style: TextStyle(fontFamily: 'Roboto-Regular',fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),)
                          )
                        ],
                      ),
                    )
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}
