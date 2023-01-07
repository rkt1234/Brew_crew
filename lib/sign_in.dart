import 'package:flutter/material.dart';
import 'package:note_taking_app/auth.dart';
import 'package:note_taking_app/constants.dart';

import 'loading.dart';

class SignIn extends StatefulWidget {
   final Function toggleView;
   const SignIn({super.key, required this.toggleView});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();
  bool loading=false;

  String email="";
  String password="";
  String error="";

  @override
  Widget build(BuildContext context) {
    return loading? const Loading():Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text("Sign in to Brew Crew"),
        actions: [
          TextButton.icon(onPressed:() {
            widget.toggleView();
          }, icon: const Icon(Icons.person,color: Colors.black,), label: const Text("Register",style: TextStyle(color: Colors.black),))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50,vertical:20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration,
                validator: (val)=> val!.isEmpty?'Enter an e-mail':null,
                onChanged: (val) {
                    setState(() {
                      email=val;
                    });
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "password"),
                validator: (val)=> val!.length<6?'Enter a password 6+ chars long':null,
                obscureText: false,
                onChanged: (val) {
                  setState(() {
                    password=val;
                  });
                },
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                child: const Text("Sign in",style: TextStyle(color: Colors.white),),
                onPressed: () async{
                     if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading=true;
                      });
                       dynamic result=await _auth.signInWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          error = "Could not sign in";
                          loading=false;
                        });
                      }
                    }
                },
                
              ),
              const SizedBox(
                  height: 10,
                ),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
            ],
          ),
        )
      ),
    );
  }
}