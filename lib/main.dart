import 'package:chatt/modal/user.dart';
import 'package:chatt/services/auth.dart';
import 'package:chatt/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());
 class MyApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       home: HomePage(),
     );
   }
 }
 class HomePage extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return StreamProvider<User>.value(value: AuthServices().user,
     child: MaterialApp(home: Wrapper(),
     ),
     );

   }
 }