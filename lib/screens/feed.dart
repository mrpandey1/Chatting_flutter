import 'package:chatt/modal/details.dart';
import 'package:chatt/modal/user.dart';
import 'package:chatt/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Feed extends StatelessWidget {
    final Details detail;
    Feed({this.detail});
    bool like=false;
  @override
  Widget build(BuildContext context) { 
    final user=Provider.of<User>(context);
      return StreamBuilder<UserName>(
      stream: DatabaseServices(uid: user.uid).userName,
      builder: (context, snapshot) {
        return new Container(
            padding: new EdgeInsets.all(32.0),
            child: new Center(
              child: new Column(
                children: <Widget>[
                  new Card(
                    child: new Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0.0),
                          boxShadow:[
                            BoxShadow(blurRadius: 10.0,color: Colors.white,spreadRadius: 0)
                          ]
                      ),
                      child: new Column(
                        children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.all(20.0),
                           child: Text('${detail.name} updated his profile photo',style: 
                           TextStyle(color: Colors.black),),
                         ),
                         Container(
                          //  width: MediaQuery.of(context).size.width-50,
                          //   height: MediaQuery.of(context).size.height-400,
                          height: 400,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              image: DecorationImage(
                                image: NetworkImage('${detail.profilepic}'),
                                fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text('Email - ${detail.email}'),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(15.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: <Widget>[  
                         Icon(Icons.thumb_up,color: like?Colors.blue:Colors.black,),
                           Icon(Icons.comment,color: Colors.black,),
                           Icon(Icons.share,color: Colors.black,),
                             ],
                           ),
                         )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
      }
    );
  }
}