import 'dart:convert';
import 'package:flutter/material.dart';
import '../components/background-image.dart';
import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';
import 'package:http/http.dart' as http;

import '../components/input_password.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _LoginState();
}

class _LoginState extends State<InscriptionPage> {

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isChecked = false;
  bool isLoading = false;
  String error ="";
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  RegExp usernameRegex = RegExp(r"^[a-zA-ZÀ-ÖØ-öø-ÿ\s'-]{3,50}$");
  RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  Map<String, String> messages = {};
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    super.dispose();
  }

  actionFunction() async {

    if (formKey.currentState!.validate()) {
      Map<String, dynamic> request = {
        'lastName' :usernameController.text,
        'firstName' :usernameController.text,
        'email': emailController.text,
        'password': passwordController.text
      };

      setState(() {
        isLoading = true;
      });

      final uri = Uri.parse("$url/auth/register");
      final response = await http.post(uri,
          body:jsonEncode(request),
          headers: {"Content-Type": "application/json","Authorization":"Bearer $token"}
      );
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        isLoading = false;
      });
      print(data);
      if (data['message'] == 'succes') {
        token = "${data['accesToken']}";
        request = {'email':request["email"],'type':'create' };
        await Navigator.pushNamed(context, '/verifyEmail',arguments: request);
      }
      else {
        if(data['message'] == 'account exist'){
          setState(() {
            error = 'Cet email a été déjà utilisé';
          });
        }
        else {
          setState(() {
            error = 'Email ou Mot de Passe Incorret';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Stack(

      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Center(
                child: SizedBox(
                  width: screenWidth*0.8,
                  height: screenHeight*0.98,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Créer un Compte",
                          style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 20,
                            wordSpacing: 5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text("Remplisser le formulaire pour créer votre compte",
                          style: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              fontSize: 12,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ),

                      Container(
                        child: Column(
                          children: [
                            if(error != "")
                              Text(error, style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'Roboto',
                                  fontSize: screenWidth * 0.04
                              ),),
                            Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    EntryField(
                                      text: "Nom d'utilisateur",
                                      type: "text",
                                      express: RegExp(r'^[a-zA-Z]+( )?[a-zA-Z]+$'),
                                      control: usernameController,
                                      required: true,
                                      error: "",
                                    ),

                                    EntryField(
                                      text: "Adresse Email",
                                      type: "text",
                                      express: RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                                      control: emailController,
                                      required: true,
                                      error: "",
                                    ),

                                    InputFieldPassword(
                                        label: 'Mot de passe',
                                        controller: passwordController,
                                        onTap: (){} ,
                                        focusNode: focusNode1,
                                        message: messages['Mot de passe'],
                                        toggleVisibility:
                                            () {
                                          setState(() {
                                            obscurePassword = !obscurePassword;
                                          });
                                        }, obscureText: obscurePassword,
                                        validator: (value ) {

                                          if (value == null || value.isEmpty) {
                                            return 'Le mot de passe est requis';
                                          }
                                          RegExp motDePasseRegExp = RegExp(
                                            r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[@$!%*?&])[A-Za-z0-9@$!%*?&]{8,}$',
                                          );
                                          if (!motDePasseRegExp.hasMatch(value)) {
                                            return 'Le mot de passe doit contenir au moins 8 caractères, une majuscule, un chiffre et un caractère spécial';
                                          }
                                          return null;
                                        }),

                                    InputFieldPassword(
                                      label: 'Confirmer Mot de passe',
                                      controller: confirmPasswordController,
                                      onTap: (){} ,
                                      focusNode: focusNode2,
                                      message: messages['Confirmer Password'],
                                      toggleVisibility: () {
                                        setState(() {
                                          obscureConfirmPassword = !obscureConfirmPassword;
                                        });
                                      }, obscureText: obscureConfirmPassword,
                                      validator: (value) {
                                        if (value != passwordController.text) {
                                          return 'Les mots de passe ne correspondent pas';
                                        }
                                        return null;
                                      },
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 10,bottom: 20),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Checkbox(
                                            value: isChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isChecked = value ?? false;
                                              });
                                            },
                                          ),
                                          const Expanded(child: Text("En cochant cette case, vous acceptez nos conditions d'utilisation générales et notre politique de confidentialité",
                                              style: TextStyle(fontSize:9,fontFamily: 'Roboto-Regular',fontWeight: FontWeight.bold,))
                                          ),
                                        ],
                                      ),
                                    ),

                                    Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Button(text: 'Inscription', onTap: actionFunction,width: 350),
                                        if(isLoading )
                                          const CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                      ],
                                    ),

                                     Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text("Vous avez un compte ?",style: TextStyle(fontFamily: 'Roboto-Regular',),),
                                          TextButton(
                                              onPressed: () {Navigator.pushNamed(context, '/login');},
                                              child: const Text('Se Connecter',style: TextStyle(fontFamily: 'Roboto-Regular',color: Colors.black,fontWeight: FontWeight.bold),)
                                          )
                                        ],
                                      ),

                                  ],
                                )
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );

  }
}
