import 'package:chatt/Message/messages.dart';
import 'package:chatt/modal/details.dart';
import 'package:chatt/modal/user.dart';
import 'package:chatt/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class GroupChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
        return new Container(
            child: new Center(
              child: new Column(
                children: <Widget>[
                 ListTile(
                   title: Padding(
                     padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 0),
                     child: Text('Group 1'),
                   ),
                   leading: CircleAvatar(backgroundImage: NetworkImage('https://www.freeiconspng.com/uploads/group-registration-icon-26.png'),),
                   onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatScreen()));
                   }
                    )
                    ],
                    )
            )
        );
}
}