import 'package:chatt/authenticate/authenticate.dart';
import 'package:chatt/modal/user.dart';
import 'package:chatt/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final  user=Provider.of<User>(context);
    if(user==null)
    {
    return Authenticate();
    }
    else
    {
      return Home();
    }
  }
}