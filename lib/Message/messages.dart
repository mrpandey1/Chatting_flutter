import 'package:chatt/modal/details.dart';
import 'package:chatt/modal/user.dart';
import 'package:chatt/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class ChatScreen extends StatefulWidget {

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController=TextEditingController();
  ScrollController scrollController=ScrollController();
  @override  
  String name;
  String dp;
  String receiver;
  String sender;
  @override
  Widget build(BuildContext context) {
    Firestore _fireStore=Firestore.instance;
    final user=Provider.of<User>(context);
          final details=Provider.of<List<Details>>(context);
        // print(details); 
        details.forEach((val)
        {
          if(val.uid==user.uid)
          {
            setState(() {
              name=val.name;
            });
          }
        });
    return StreamBuilder<UserName>(
      stream:  DatabaseServices(uid: user.uid).userName,
      builder: (context, snapshot) {
        if(snapshot.hasData)
        {
          
          return Scaffold(
          appBar: AppBar(title: Text('Group 1')
          ,backgroundColor: Colors.purpleAccent,),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream:_fireStore.collection('message').orderBy('date').snapshots(),
                    builder: (context,snapshot){
                      if(!snapshot.hasData)
                      {
                        return Center(
                          child: CircularProgressIndicator(
                          )
                        );
                      }
                      List<DocumentSnapshot> docs=snapshot.data.documents;
                      List<Widget> message=docs.map((docs)=>
                        Message(
                        from: docs.data['from'],
                        text: docs.data['message'],
                        me: name == docs.data['from']?true:false)
                      ).toList();
                      
                      return ListView(
                        controller: scrollController,
                        children: <Widget>[
                       ...message,
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter message ...',
                            border: const OutlineInputBorder(
                            )
                          ),
                          controller: messageController,
                        ),
                      ),
                      SendButton(
                        callback: ()
                        {
                          var now=DateTime.now();
                          DatabaseServices(uid: user.uid).updateUserMessage(
                            messageController.text,
                           name, 
                           '',                           
                           now.toString(),
                        );
                        messageController.clear();
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          curve:Curves.easeOut,
                          duration: Duration(microseconds: 300),
                        );
                        },
                        text: ('Send'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
        }
        
      }
    );
  }
}
class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({Key key, this.text, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: callback,
    padding: EdgeInsets.all(22),
    color: Colors.pink,
    child: Text(text,style: TextStyle(color: Colors.white),),
    );
  }
  }
class Message extends StatelessWidget {
  final String from;
  final String text;
  final bool me;

  const Message({Key key, this.from, this.text, this.me}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: me?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: <Widget>[
          Text(from),
          Material(
            color: me?Colors.blue:Colors.pink,
            borderRadius: BorderRadius.circular(10),
            elevation: 6,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Text(text),
              ),
          ),
        ]
        ,)
        ,
    );
  }
}

// import 'package:chatt/modal/details.dart';
// import 'package:chatt/modal/user.dart';
// import 'package:chatt/services/database.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// class ChatScreen extends StatefulWidget {
//   final Details to;
//   const ChatScreen({Key key, this.to}) : super(key: key);

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   TextEditingController messageController=TextEditingController();
//   ScrollController scrollController=ScrollController();

//   String name;
//   String dp;
//   String receiver;
//   String sender;
//   @override
//   Widget build(BuildContext context) {
//     Firestore _fireStore=Firestore.instance;
//     final user=Provider.of<User>(context);
//           final details=Provider.of<List<Details>>(context);
//         // print(details); 
//         details.forEach((val)
//         {
//           if(val.uid==user.uid)
//           {
//             setState(() {
//               name=val.name;
//             });
//           }
//         });
//     return StreamBuilder<UserName>(
//       stream:  DatabaseServices(uid: user.uid).userName,
//       builder: (context, snapshot) {
//         if(snapshot.hasData)
//         {
//           return Scaffold(
//           appBar: AppBar(title: Text('Group 1')
//           ,backgroundColor: Colors.purpleAccent,),
//           body: SafeArea(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Expanded(
//                   child: StreamBuilder<QuerySnapshot>(
//                     stream:_fireStore.collection('message').orderBy('date',descending:false).snapshots(),
//                     builder: (context,snapshot){
//                       if(!snapshot.hasData)
//                       {
//                         return Center(
//                           child: CircularProgressIndicator(
//                           )
//                         );
//                       }
//                       List<DocumentSnapshot> docs=snapshot.data.documents;
//                       List<Widget> message=docs.map((docs)=>
//                         Message(
//                         from: docs.data['from'],
//                         text: docs.data['message'],
//                         me: name == docs.data['from']?true:false)
//                       ).toList();
                      
//                       return ListView(
//                         controller: scrollController,
//                         children: <Widget>[
//                        ...message,
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//                 Container(
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Enter message ...',
//                             border: const OutlineInputBorder(
//                             )
//                           ),
//                           controller: messageController,
//                         ),
//                       ),
//                       SendButton(
//                         callback: ()
//                         {
//                           var now=DateTime.now();
//                           DatabaseServices(uid: widget.to.uid).updateUserMessage(
//                             messageController.text,
//                            name, 
//                            '',                           
//                            DateFormat('dd-mm-yyyy').format(now)
//                         );
//                         messageController.clear();
//                         scrollController.animateTo(
//                           scrollController.position.maxScrollExtent,
//                           curve:Curves.easeOut,
//                           duration: Duration(microseconds: 300),
//                         );
//                         },
//                         text: ('Send'),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//         }
        
//       }
//     );
//   }
// }
// class SendButton extends StatelessWidget {
//   final String text;
//   final VoidCallback callback;

//   const SendButton({Key key, this.text, this.callback}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return FlatButton(
//       onPressed: callback,
//     padding: EdgeInsets.all(22),
//     color: Colors.pink,
//     child: Text(text,style: TextStyle(color: Colors.white),),
//     );
//   }
//   }
// class Message extends StatelessWidget {
//   final String from;
//   final String text;
//   final bool me;

//   const Message({Key key, this.from, this.text, this.me}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: me?CrossAxisAlignment.end:CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(from),
//           Material(
//             color: me?Colors.blue:Colors.pink,
//             borderRadius: BorderRadius.circular(10),
//             elevation: 6,
//             child: Container(
//               padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
//               child: Text(text),
//               ),
//           ),
//         ]
//         ,)
//         ,
//     );
//   }
// }
