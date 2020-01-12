import 'package:chatt/modal/details.dart';
import 'package:chatt/screens/groupchat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class GroupChat extends StatefulWidget {
  @override
  _GroupChatState createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  @override
  Widget build(BuildContext context) {
    // final details=Provider.of<List<Details>>(context)??[];
    //print(brews);
    //printing the collections of firebase
        return GroupChats();
  }
}