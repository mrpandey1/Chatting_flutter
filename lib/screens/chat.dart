import 'package:chatt/modal/details.dart';
import 'package:chatt/screens/ChatList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    final details=Provider.of<List<Details>>(context)??[];
    //print(brews);
    //printing the collections of firebase
   
    return Container(
          child: ListView.builder(
        itemCount: details.length,
        itemBuilder: (context,index){
          return ChatList(detail: details[index]);
        },
      ),
    );
  }
}
