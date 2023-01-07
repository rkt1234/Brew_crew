import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_taking_app/database.dart';
import 'package:note_taking_app/user.dart';

class AuthService
{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  //create user obj based on firebase user
  MyUser? _userFromFirebase(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }
  //auth change  stream
   Stream<MyUser?> get user {
    return _auth
        .authStateChanges().map((User? user) => _userFromFirebase(user!)!);
  }

  //sign in anonymously
  Future signInAnon() async
{
  try
  {
    // ignore: unused_local_variable
    UserCredential result= await _auth.signInAnonymously();
    User? user=result.user;
    return _userFromFirebase(user!);
  }

  catch(e)
  {
    // ignore: avoid_print
    print(e.toString());
    return null;

  }

}

  //register with email password
  Future registerWithEmailAndPassword(String email, String password) async
  {
     try
     {
        UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User? user= result.user;
        //create a new document for the user with the uid
        await DatabaseService(uid:user!.uid).updateUserData('0','new member',100);
        return _userFromFirebase(user);
     }

     catch(e)
     {
          // ignore: avoid_print
          print(e.toString());
          return null;
     }
  }

  //sign in with email password
  Future signInWithEmailAndPassword(String email, String password) async
  {
     try
     {
        UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
        User? user= result.user;
        return _userFromFirebase(user);
     }

     catch(e)
     {
          // ignore: avoid_print
          print(e.toString());
          return null;
     }
  }

  //sign out
  Future signOut() async
  {
    try
    {
      return await _auth.signOut();
    }
    catch(e)
    {
         // ignore: avoid_print
         print(e.toString());
         return null;
    }
  }

}