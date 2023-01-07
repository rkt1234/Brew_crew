import 'package:flutter/material.dart';
import 'package:note_taking_app/register.dart';
import 'package:note_taking_app/sign_in.dart';
class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

bool showSignIn=true;
 toggleView ()
{
  setState(() {
    showSignIn= !showSignIn;
  });
}

  @override
  Widget build(BuildContext context) {
   if(showSignIn) {
     return SignIn(toggleView:toggleView);
   } else {
     return Register(toggleView:toggleView);
   }
  }
}