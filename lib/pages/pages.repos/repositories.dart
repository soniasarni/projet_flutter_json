import 'dart:convert';

import'package:flutter/material.dart';
import'package:http/http.dart'as http;
class GitRepositoryPage extends StatefulWidget {

String login;
GitRepositoryPage({required this.login});

  @override
  _GitRepositoryPageState createState() => _GitRepositoryPageState();
}

class _GitRepositoryPageState extends State<GitRepositoryPage> {
 dynamic dataRepositores;
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadRepositories();
  }
  void loadRepositories()async{
    String url="https://api.github.com/search/users?q=${widget.login}/repos";
   http.Response response=await http.get(Uri.parse(url));
   if(response.statusCode==200){
     setState(() {
       dataRepositores=json.decode(response.body);
     });
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text('Repositories ${widget.login}'),),
      drawer:Drawer(),
      body:Center(
        child:ListView(),
      ),
    );
  }
}