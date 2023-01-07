import 'package:flutter/material.dart';
import 'package:note_taking_app/auth.dart';
import 'package:note_taking_app/constants.dart';

import 'loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
   bool loading=false;

  String email = "";
  String password = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return loading?const Loading():Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text("Sign up to Brew Crew"),
        actions: [
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: const Text(
                "Sign in",
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration:textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Enter an e-mail' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "password"),
                  obscureText: true,
                  validator: (val) =>
                      val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text(
                    "Sign up",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading=true;

                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          error = "please supply a valid emial";
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
          )),
    );
  }
}
