import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_taking_app/user.dart';
import 'brew.dart';

class DatabaseService
{
  final String uid;
  DatabaseService({required this.uid});
   // collection reference 
   final CollectionReference brewCollection=FirebaseFirestore.instance.collection('brews');
   Future updateUserData(String sugars,String name,int strength) async
   {
     return await brewCollection.doc(uid).set({
     'sugars':sugars,
     'name':name,
     'strength':strength,
     });
   }
   //brew list from snapshot
    List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((d) {
        return Brew(
          name: d.get("name") ?? "",
          sugars: d.get("sugars") ?? "0",
          strength: d.get("strength") ?? 0,
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
  // user data from snapshot
   UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name'), 
      strength:snapshot.get('strength'),
      sugars: snapshot.get('sugar'),
      );
  }

   //get brews stream
   Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(_brewListFromSnapshot);
   }
   // get user doc stream
   Stream<UserData> get userData 
   {
     return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);

   }
}