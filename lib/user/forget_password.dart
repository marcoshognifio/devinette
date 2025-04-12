import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/components.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

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
              padding: EdgeInsets.only(top:80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mot de Passe Oublié",
                    style: TextStyle(
                      fontFamily: 'Roboto-Regular',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text("Entrer votre Adresse Email",
                      style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          fontSize: 12,
                          fontWeight: FontWeight.w600
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
                      text: "Adresse Email",
                      type: "text",
                      express: RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                      control: emailController,
                      required: true,
                      error: "",
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Button(text: "Envoyer", onTap: () { Navigator.pushNamed(context, '/verifyEmail'); },width: 350,),
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
