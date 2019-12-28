import 'package:chatt/modal/details.dart';
import 'package:chatt/screens/chat.dart';
import 'package:chatt/screens/group.dart';
import 'package:chatt/screens/profile.dart';
import 'package:chatt/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatt/services/database.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState()
  {
    super.initState();
    tabController=new TabController(length: 3,vsync: this);
  }
 final AuthServices _auth=AuthServices();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Details>>.value(
      value: DatabaseServices().details,
      child: MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Kya Haal ?'),
            backgroundColor: Colors.purpleAccent,
            bottom:   TabBar(
          controller: tabController,
          tabs: <Widget>[
            new Tab(icon: Icon(Icons.chat),),
            new Tab(icon: Icon(Icons.group),),
            new Tab(icon: Icon(Icons.person),),
          ],
        ),
      ),
      body: new TabBarView(
        controller: tabController,
        children: <Widget>[
          Chat(),
          Group(),
          Profile()
        ],
      ),
          ),
        ),
      ),
    );   
  }
}
//appBar: AppBar(
    //     title: Text('Home'),
    //     backgroundColor: Colors.purpleAccent,
    //     actions: <Widget>[
    //       FlatButton.icon(
    //         onPressed: ()async{
    //           _auth.signOut();
    //         },
    //         icon: Icon(Icons.person),
    //         label: Text('Logout'),
    //       )
    //     ],
    //   bottom: Material(
    //     color: Colors.purpleAccent,
    //     child: TabBar(
    //       controller: tabController,
    //       tabs: <Widget>[
    //         new Tab(icon: Icon(Icons.chat),),
    //         new Tab(icon: Icon(Icons.group),),
    //         new Tab(icon: Icon(Icons.person),),
    //       ],
    //     ),
    //   ),
    //   body: new TabBarView(
    //     controller: tabController,
    //     children: <Widget>[
    //       Chat(),
    //       Group(),
    //       Profile()
    //     ],
    //   ),
    // ),
    // );