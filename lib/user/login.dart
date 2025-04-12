import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../components/background-image.dart';
import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isChecked = false;
  bool isLoading = false;
  String error = "";

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

  actionFunction() async {
    //print('coucou${screenWidth*0.05}');
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> request = {
        'email': emailController.text,
        'password': passwordController.text
      };

      setState(() {
        isLoading = true;
      });
      final uri = Uri.parse("$url/auth/login");
      final response = await http.post(uri,
          body: jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }
      );
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        isLoading = false;
      });
      print(data);
      if (data['message'] == 'succes' && data['role']=='subscribe') {

        accessToken = data['accesToken'];
        refreshToken = data['refreshToken'];
        currentUser = data['user'];
        await DatabaseHelper().getUserProfile();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Connexion réussie!'),
            duration: Duration(seconds: 3),
          ),
        );
        await Navigator.pushNamed(context, '/userSlide');
      }
      else {
        setState(() {
          error = 'Email ou Mot de Passe Incorret';
        });
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
                          const Padding(
                            padding: EdgeInsets.only(bottom: 7.0,top: 50),
                            child: Text("Bienvenue sur FAGBASSA",
                              style: TextStyle(
                                fontFamily: 'Roboto-Regular',
                                fontSize: 20,
                                wordSpacing: 5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Text("Entrer votre email et votre mot de passe pour continuer",
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
                                          text: "Adresse Email",
                                          type: "text",
                                          express: RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                                          control: emailController,
                                          required: true,
                                          error: "",
                                        ),

                                        EntryField(
                                          text: "Mot de Passe",
                                          type: "password",
                                          express: RegExp(r''),
                                          control: passwordController,
                                          required: true,
                                          error: "",
                                        ),
                                        Row(
                                          children: [
                                            const Spacer(),
                                            TextButton(
                                                onPressed: () {Navigator.pushNamed(context, '/forgetPassword');},
                                                child: const Text("Mot de Passe Oublié ?",style: TextStyle(fontFamily: 'Roboto-Regular',color: Colors.black,fontWeight: FontWeight.bold),)
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: screenHeight*0.1,),
                                        Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Button(text: 'Se Connecter', onTap: actionFunction,width: 350),
                                            if(isLoading )
                                              const CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Text("Vous n'avez pas de compte ?",style: TextStyle(fontFamily: 'Roboto-Regular',),),
                                            TextButton(
                                                onPressed: () {Navigator.pushNamed(context, '/inscription');},
                                                child: const Text("S'inscrire",style: TextStyle(fontFamily: 'Roboto-Regular',color: Colors.black,fontWeight: FontWeight.bold),)
                                            )
                                          ],
                                        )
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
