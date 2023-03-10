import 'package:note_taking_app/database.dart';
import 'package:note_taking_app/user.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'package:flutter/material.dart';

import 'loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  // form values
   String _currentName="";
   String _currentSugars='0';
    int _currentStrength=100;
    //String s=UserData.name;
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<MyUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid! ).userData,
      builder: (context,snapshot){
        if((!snapshot.hasData)){
          UserData? userData=snapshot.data;
      return  Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const Text(
              'Update your brew settings.',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            //Text((userData?.name).toString()),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: "Enter your name"),
              validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            const SizedBox(height: 10.0),
            DropdownButtonFormField(
              value: _currentSugars,
              decoration: textInputDecoration,
              items: sugars.map((sugar) {
                return DropdownMenuItem(
                  value: sugar,
                  child: Text('$sugar sugars'),
                );
              }).toList(),
              onChanged: (val) => setState(() => _currentSugars = val! ),
            ),
            const SizedBox(height: 10.0),
            Slider(
              value: (_currentStrength).toDouble(),
              activeColor: Colors.brown[_currentStrength],
              inactiveColor: Colors.brown[_currentStrength],
              min: 100.0,
              max: 900.0,
              divisions: 8,
              onChanged: (val) => setState(() => _currentStrength = val.round()),
            ),
            ElevatedButton(
              
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if(_formKey.currentState!.validate())
                {
                     await DatabaseService(uid: user.uid!).updateUserData(_currentSugars,_currentName??userData!.name,_currentStrength??userData!.strength);
                     Navigator.pop(context);
                }
              }
            ),
          ],
        ),
      );
      }
      else
      return Loading();
      }
    );
  }
}