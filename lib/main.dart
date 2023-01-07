import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/auth.dart';
import 'package:note_taking_app/user.dart';
import 'package:note_taking_app/wrapper.dart';
import 'package:provider/provider.dart';

Future <void> main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      catchError: (_,__) {
        return null;
      },
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Wrapper(),
      ),
    );
  }
}
