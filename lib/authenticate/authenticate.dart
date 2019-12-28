import 'package:chatt/authenticate/register.dart';
import 'package:chatt/authenticate/signin.dart';
import 'package:flutter/material.dart';
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
bool iSignup=true;
void toggleView()
{
  setState(() {
    iSignup=!iSignup;
  });
}
  @override
  Widget build(BuildContext context) {
    if(iSignup)
    {
      return SignIn(toggleView: toggleView);
    }
    else
    {
      return SignUp(toggleView: toggleView);
    }
  }
}