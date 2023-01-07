import 'package:flutter/material.dart';
import 'brew.dart';

class BrewTile extends StatelessWidget {
   const BrewTile({super.key,required this.brew});
   
   final Brew brew;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        margin:const EdgeInsets.fromLTRB(20,6,20,0),
         child: ListTile(
          leading: CircleAvatar(radius: 25,backgroundColor: Colors.brown[brew.strength],backgroundImage: NetworkImage("https://i.dailymail.co.uk/i/pix/scaled/2015/03/09/0C07226D00000578-0-image-a-23_1425939890281.jpg"),),
          title: Text(brew.name),
          subtitle: Text("Take ${brew.sugars} sugar(s)"),
         ),

      ),
    );
  }
}