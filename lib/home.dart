import 'brew.dart';
import 'brew_list.dart';
import 'setting_form.dart';
import 'auth.dart';
import 'database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  Home({super.key});

  @override
  Widget build(BuildContext context) {

    // ignore: no_leading_underscores_for_local_identifiers
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: '').brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person,color: Colors.black,),
              label: const Text('logout',style: TextStyle(color: Colors.black),),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.settings,color: Colors.black,),
              label: const Text('settings',style: TextStyle(color: Colors.black),),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
               image: NetworkImage("https://thumbs.dreamstime.com/b/espresso-coffee-grain-real-72986321.jpg"),
               fit: BoxFit.cover,
            )
          ),
          child: const BrewList()),
      ),
    );
  }
}