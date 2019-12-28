import 'package:chatt/services/auth.dart';
import 'package:chatt/services/database.dart';
import 'package:chatt/shared/decoration.dart';
import 'package:chatt/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String error='';
  String email;
  String displayName;
  String password;
  bool loading=false;
  final AuthServices _auth=AuthServices();
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Signup to Kya Haal'),
        backgroundColor: Colors.purpleAccent,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Login'),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText:'Email'),
                validator: (val)=>val.isEmpty?'please enter email':null,
                onChanged: (val){
                  setState(() {
                      email=val;
                    });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                decoration: textInputDecoration.copyWith(hintText:'Password'),
                validator: (val)=>val.length<6?'password is quite small':null,
                onChanged: (val){
                  setState(() {
                      password=val;
                    });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText:'Your Name'),
                validator: (val)=>val.isEmpty?'please enter name':null,
                onChanged: (val){
                  setState(() {
                      displayName=val;
                    });
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.purpleAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Register',style: TextStyle(color: Colors.white),),
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate())
                  {
                    setState(() => loading=true);
                    dynamic result=await _auth.userRegistrationwithEmailPasssword(email, password,displayName);
                    if(result==null)
                    {
                    setState(() {
                      loading=false;
                      error='invalid email format or already used email';   
                    });
                  }
                  }
                },
              ),
              SizedBox(height: 30,),
              Center(
                child: Text(error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}