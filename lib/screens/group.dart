import 'package:chatt/modal/details.dart';
import 'package:chatt/screens/feed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Group extends StatefulWidget {
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  @override
  Widget build(BuildContext context) {
    final details=Provider.of<List<Details>>(context)??[];
    //print(brews);
    //printing the collections of firebase
   
    return ListView.builder(
      itemCount: details.length,
      itemBuilder: (context,index){
        return Feed(detail: details[index]);
      },
    );
  }
}