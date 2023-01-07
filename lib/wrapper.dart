import 'package:flutter/material.dart';
import 'package:note_taking_app/authenticate.dart';
import 'package:note_taking_app/home.dart';
import 'package:note_taking_app/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user=Provider.of<MyUser?>(context);
    //print(user);
    if(user==null)
    {
      return const Authenticate();
    }
    else
    {
      return Home();
    }
    
  }
}