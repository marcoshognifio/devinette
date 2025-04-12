import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/button.dart';
import '../components/data_class.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key,required this.data});
  final Map<String,dynamic> data;

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  String _code = "";
  bool isLoading = false;
  String error ="";

  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
    super.initState();
  }

  void _onTextChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
    _code = '$_code$value';
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }

    if(index == 5){
      actionFunction();
    }
  }

  actionFunction() async {

    setState(() {
      isLoading = true;
    });

    if (_code.length == 6){
      Map<String, dynamic> request;
      String urlHelp = '';

      if (widget.data['type'] == 'create') {
        request = {
          'code': _code,
        };
        urlHelp = '$url/code/validation/account';
      } else {
        request = {
          'code': _code,
        };
        urlHelp = '$url/auth/forgot-password/reset-password';
      }

      final uri = Uri.parse(urlHelp);
      final response = await http.post(
        uri,
        body: jsonEncode(request),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        isLoading = false;
      });


      print(data);
      if (data['message'] == 'succes') {
        token = data['token'];
        if (widget.data['type'] == 'create') {
          await Navigator.pushNamed(context, '/login');
        } else {
          await Navigator.pushNamed(context, '/changeForgetPassword');
        }
      } else {
        setState(() {
          error = data['message'];
        });
      }
    }
    else {
      setState(() {
        error = "Veuillez remplir tous les champs.";
      });
    }
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
                  Text("Vérification du Code",
                    style: TextStyle(
                      fontFamily: 'Roboto-Regular',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Text("Entrer les 6 chiffres envoyés sur votre Email",
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              return Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  showCursor: false,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20,color: Colors.black),
                  decoration: const InputDecoration(
                    counterText: "",
                    contentPadding: EdgeInsets.only(top: 10),
                    isDense: true,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                  ),
                  onChanged: (value) => _onTextChanged(index, value),
                ),
              );
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Si vous n'avez pas reçu de code ?",
                style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontSize: 12,
                    fontWeight: FontWeight.w600
                ),
              ),
              TextButton(
                  onPressed: () {Navigator.pushNamed(context, '/inscription');},
                  child: const Text("Renvoyer",style: TextStyle(fontFamily: 'Roboto-Regular',color: Colors.black,fontWeight: FontWeight.bold),)
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Button(text: "Envoyer", onTap: () { Navigator.pushNamed(context, '/updatePassword'); },width: 350,),
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
      ),
    );
  }
}
