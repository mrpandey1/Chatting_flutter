import 'package:chatt/Message/messages.dart';
import 'package:chatt/modal/details.dart';
import 'package:chatt/modal/user.dart';
import 'package:chatt/screens/pcchat.dart';
import 'package:chatt/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ChatList extends StatelessWidget {
    final Details detail;
    ChatList({this.detail});
    bool like=false;
  @override
  Widget build(BuildContext context) { 
    final user=Provider.of<User>(context);
      return StreamBuilder<UserName>(
      stream: DatabaseServices(uid: user.uid).userName,
      builder: (context, snapshot) {
        if(user.uid!=detail.uid)
        {
        return new Container(
            child: new Center(
              child: new Column(
                children: <Widget>[
                 ListTile(
                   title: Padding(
                     padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 0),
                     child: Text('${detail.name}'),
                   ),
                   leading: CircleAvatar(backgroundImage: NetworkImage('${detail.profilepic}'),),
                   onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PcChat(to:detail)));
                   }
                    )
                    ],
                    )
            )
        );
      }
      else
        return Container();
      }
      );
  }
}
               