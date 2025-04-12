import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/components.dart';

class WelcomeUser extends StatefulWidget {
  const WelcomeUser({super.key});

  @override
  State<WelcomeUser> createState() => _WelcomeUserState();
}

class _WelcomeUserState extends State<WelcomeUser> {

  TextEditingController searchController = TextEditingController();
  final form = GlobalKey<FormState>();


  searchAction(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: EntrySearch(text: 'Rechecher',control: searchController,formKey: form, onTap: searchAction),
                  )
                ],
              ),
        ),
    );
  }
}
