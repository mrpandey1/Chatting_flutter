import 'package:chatt/modal/details.dart';
import 'package:chatt/modal/user.dart';
import 'package:chatt/services/database.dart';
import 'package:chatt/shared/decoration.dart';
import 'package:chatt/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey=GlobalKey<FormState>();
  String name;
  @override
  Widget build(BuildContext context) {
  final user=Provider.of<User>(context);
    return StreamBuilder<UserName>(
      stream: DatabaseServices(uid: user.uid).userName,
      builder: (context, snapshot) {
        if(snapshot.hasData)
        {
          UserName user=snapshot.data;
                return Container(
                    height: MediaQuery.of(context).size.height-200,
                    color: Colors.purple.withOpacity(0.1),
                    child:
                    Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20,4),
                        child: Column(children: <Widget>[
                          Text('Update your Name',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.pink[900]
                          ),),
                          SizedBox(height: 10,),
                          TextFormField( 
                            initialValue: user.name,
                            decoration: textInputDecoration,
                            onChanged: (val)
                            {
                              name=val;
                            },
                          ),
                          SizedBox(height: 10,),
                          RaisedButton(onPressed: ()async{
                          if(_formKey.currentState.validate())
                            {
                              await DatabaseServices(uid: user.uid).updateUserData(
                                name??user.name, 
                                user.email, 
                                user.profilepic
                                );
                            Navigator.pop(context);
                            }
                          },
                          child: Text('Submit',style: TextStyle(color: Colors.white),),
                          color: Colors.pink[400],
                          )
                        ],),
                      ),
                    ),
                  )
                  );
        }
        else{
            Loading();
        }
        
      }
    );

    
  }
}