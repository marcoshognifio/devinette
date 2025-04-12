import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/data_class.dart';

class InfoProfit extends StatefulWidget {
  const InfoProfit({super.key});

  @override
  State<InfoProfit> createState() => _InfoProfitState();
}

class _InfoProfitState extends State<InfoProfit> {

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final telephoneController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    telephoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    usernameController.text = "CHABI ANNE-MARIE";
    emailController.text = "mafin@Figma.com";
    telephoneController.text = "+229 55 666 222";

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 20),
        width: 320,
        child: Column(
          children: [
            EditField(
                text: "NOM & PRENOM",
                type: "text",
                express: RegExp(r'^[a-zA-Z]+( )?[a-zA-Z]+$'),
                control: usernameController,
                required: true,
                error: "",
            ),

            EditField(
                text: "EMAIL",
                type: "text",
                express: RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                control: emailController,
                required: true,
                error: "",
            ),

            EditField(
                text: "NUMERO",
                type: "text",
                express: RegExp(r''),
                control: telephoneController,
                required: true,
                error: "",
            ),

            Padding(
              padding: const EdgeInsets.only(top:50.0),
              child: Button(text: 'MODIFIER', onTap: () {  },width: 350,),
            )
          ],
        ),
      ),
    );
  }
}

class EditField extends StatefulWidget {
  EditField({super.key,required this.text,required this.type,required this.express,
    required this.control,required this.required,required this.error});
  final String  text, type;
  final RegExp express;
  TextEditingController control;
  final bool required;
  final String error;

  @override
  State<EditField> createState() => _EditFieldState();
}

class _EditFieldState extends State<EditField> {

  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:  4.0),
            child: Text(widget.text,style: const TextStyle(
              fontFamily: 'Roboto-Regular',
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),),
          ),
          SizedBox(
            height: 38,
            child: TextFormField(
              style: const TextStyle(
                  fontFamily: 'Roboto-Regular',
                  color: Colors.black,
                  fontSize: 16
              ),
              controller: widget.control,
              obscureText: widget.type == 'password' ? isObscured : false,
              validator: (value) {
                if(widget.required == true )
                {
                  if(value!.isEmpty){
                    return 'Ce champ est obligatoire';
                  }
                  if (!widget.express.hasMatch(value))
                  {
                    return widget.error;
                  }
                  return null;
                }
                else
                {
                  if (value!.isNotEmpty && !widget.express.hasMatch(value))
                  {
                    return widget.error;
                  }
                  else {
                    return null;
                  }
                }
              },
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.all(10),
                  iconColor: colorApp,
                  hoverColor: Colors.white,
                  suffixIcon: widget.type == 'password' ?  IconButton(
                      padding: const EdgeInsetsDirectional.only(end: 12),
                      onPressed:(){
                        setState(() {
                          isObscured = isObscured == true ? false:true;
                        });
                      }
                      , icon:Icon( isObscured == false ? Icons.visibility : Icons.visibility_off)
                  ):null
              ),
            ),
          ),
        ],
      ),
    );
  }
}
