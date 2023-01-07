class MyUser
{
  final String? uid;

  // ignore: prefer_typing_uninitialized_variables
  static var empty;
  MyUser({ this.uid});
}

class UserData
{
   final String uid;
    String name;
   final String sugars;
   final int strength;

  UserData({required this.uid,required this.strength,required this.name, required this.sugars,});

}