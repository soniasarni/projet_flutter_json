import 'package:flutter/material.dart';
import 'package:second_project/pages/pages.home/home.page.dart';
import 'package:second_project/pages/pages.users/users.page.dart';

void main() =>
  runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,

      theme:ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      routes:{
        "/":(context)=>HomePage(),
        "/users":(context)=>UsersPage()
      },


      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

