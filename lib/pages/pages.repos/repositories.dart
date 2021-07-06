import 'dart:convert';

import'package:flutter/material.dart';
import'package:http/http.dart'as http;
class GitRepositoryPage extends StatefulWidget {

String login;
String avatarUrl;

GitRepositoryPage({required this.login,required this.avatarUrl});


  @override
  _GitRepositoryPageState createState() => _GitRepositoryPageState();
}

class _GitRepositoryPageState extends State<GitRepositoryPage> {
 dynamic dataRepositories;
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadRepositories();
  }
  void loadRepositories()async{
    String url="https://api.github.com/users/${widget.login}/repos";
   http.Response response=await http.get(Uri.parse(url));
   if(response.statusCode==200){
     setState(() {
       dataRepositories=json.decode(response.body);
     });
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text('Repositories ${widget.login}'),
      actions:[CircleAvatar(
        backgroundImage:NetworkImage(
widget.avatarUrl,
        )
      ),

      ]),
      body:Center(
        child:ListView.separated(
            itemBuilder: (context,index)=>
                ListTile(
                title:Text("${dataRepositories[index]['name']}"),
                ),
            separatorBuilder: (context,index)=>
                Divider(height:2,color:Colors.deepOrange),
            itemCount: dataRepositories==null?0:dataRepositories.length,
        ),
      ),
    );
  }
}