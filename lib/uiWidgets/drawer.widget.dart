import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class My_Drawer extends StatelessWidget {
  const My_Drawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:ListView(
        children:[
          DrawerHeader(
            decoration:BoxDecoration(
                gradient:LinearGradient(
                    colors:[
                      Colors.yellow,
                      Colors.deepOrange

                    ]

                )
            ),
            child:Center(
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      CircleAvatar(
                        radius:30,
                        backgroundImage:AssetImage("images/logo.jpeg"),
                      ),
                      CircleAvatar(
                        radius:40,
                        backgroundImage:AssetImage("images/profile.jpeg"),
                      ),
                    ])
            ),
          ),
          ListTile(
            title:Text('home',style:TextStyle(fontSize:22),),
            leading:Icon(Icons.home,color:Colors.orange,),
            trailing:Icon(Icons.arrow_right,color:Colors.orange,),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/home");
            },
          ),
          Divider(height:2,color:Colors.amberAccent,),
          ListTile(
            title:Text('Offers',style:TextStyle(fontSize:22),),
            leading:Icon(Icons.assignment_rounded,color:Colors.orange,),
            trailing:Icon(Icons.arrow_right,color:Colors.orange,),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/offers");
            },
          ),
          Divider(height:2,color:Colors.amberAccent,),
          ListTile(
            title:Text("Login",style:TextStyle(fontSize:22),),
            leading:Icon(Icons.assignment_ind_sharp,color:Colors.orange,),
            trailing:Icon(Icons.arrow_right,color:Colors.orange,),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context,"/login");
            },
          ), ListTile(
            title:Text('Counter',style:TextStyle(fontSize:22),),
            leading:Icon(Icons.home,color:Colors.orange,),
            trailing:Icon(Icons.arrow_right,color:Colors.orange,),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/counter");
            },
          ),
          /*une autre methode pour naviguer
           ...(GlobalParams as List).map((item) {
            return ListTile(
              title:Text('${item['title']}',style:TextStyle(fontSize:22),),
              leading:Icon(Icons.map),
              trailing:Icon(Icons.arrow_right,color:Colors.orange,),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/${item['route']}");
             },
            );
            })*/
        ],
      ),
    );
  }
}