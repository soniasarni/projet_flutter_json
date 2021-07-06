import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import'package:http/http.dart'as http;
import 'package:second_project/pages/pages.repos/repositories.dart';
class   UsersPage extends StatefulWidget {
  //stocker la valeur recup
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String query="";
  bool notVisible=false;
  //les donner json recuperer sont de type text alors il faut les stocker d'un objet de type dart du coup
  dynamic data;
  //realiser un systeme de pagenation et paramettrer la requet
  int currentPage=0;
  int totalPages=0;
  int pageSize=20;
//controller le scrolling
ScrollController scrollController=new ScrollController();
//enregistrer une liste des donnees apres le scroll
  List<dynamic>items=[];
//faire une requet http vers la partie backend pour recuperer les donnees API
  void _search(String query){
    String url ="https://api.github.com/search/users?q=${query}&per_page=>$pageSize&page=$currentPage";
    print(url);
    http.get(Uri.parse(url))
        .then((response) {
          setState(() {
            this.data=json.decode(response.body);
            this.items.addAll(data['items']);
            //CALCULER LE NOMBRE DE PAGES pour avoir une division entiere
            //ON AJOUTE~ ou bien on ajoute floor()
            if(data['total_count']%pageSize==0){
              this.totalPages=data['total_count']~/pageSize;
            }else{
              totalPages=(data['total_count']/pageSize).floor()+1;
              print('total_count');
            }


            print(response.body);

          });
    })
        .catchError((Error){

    });
  }
  @override
  void initState(){
super.initState();
scrollController.addListener(() {
  if (scrollController.position.pixels==scrollController.position.maxScrollExtent){
    setState(() {
      if(currentPage<totalPages-1) {
        ++currentPage;
        _search(query);
      }
    });
  }
});
  }
  TextEditingController queryTextEditingController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text('Users=>${query}=> $currentPage / $totalPages'),),
      body:Center(
        child:Column(
    children:[
      Row(
        children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.all(10),
                //comment formater un textformField
                child: TextFormField(
                  //utilise generalement pour mdp
                  obscureText:notVisible,
                  //DANS CE CAS ON A QUELQUE CHOSE DE REACTIF
                  onChanged:(value){
                    setState(() {
                      this.query=value;
                    });
                  },
                  //controller qui permet de recuperer les valeurs
                  controller: queryTextEditingController,
                  decoration: InputDecoration(
                    //dans decoration on peut specifier plusieurs choses icons,bordures,
                    //icon:Icon(Icons.logout),
                      //suffixIcon:Icon(Icons.visibility),
                    //icone devient un botton et quand je clicc bool prend l'autre valeur
                      suffixIcon:IconButton(
                        onPressed: (){
                          setState(() {
                            notVisible=!notVisible;
                          });
                        },
                        //CHANGEMENT DE L4ICON SELON LE BOOL
                        icon:Icon(
                          notVisible==true?Icons.visibility_off:Icons.visibility
                        ),
                                    ),
                      contentPadding:EdgeInsets.only(left: 20),
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(30) ,
                          borderSide: BorderSide(
                              width: 1,color:Colors.deepOrange
                          )
                      )
                  ) ,
                )),
          ),
         IconButton(
           icon: Icon(Icons.search,color:Colors.deepOrange),
           //recuperer la valeur de text
           onPressed:(){
           // avec statless this.query=queryTextEditingController.text;

     //print(query);
             //setState(()est une methode qu'on herite de la class state elle permet de rafrechir la page

             setState((){
               items=[];
               currentPage=0;
               this.query=queryTextEditingController.text;
               _search(query);
             });
           },)
        ],
      ),
      //je vais afficher mes donner dans un listview
      Expanded(
        //child: ListView.builder(
    //UTILISER UNE AUTRE LISTE QUI VA SEPARER LES DONNES
        child: ListView.separated(
          separatorBuilder: (contest,index)=>
              Divider(height:2,color:Colors.amberAccent,),
          controller:scrollController,
          itemCount:items.length ,
          //itemCount:(data==null)?0:data['items'].length,
            itemBuilder:(context,index){
            return ListTile(
              //quand je clic sur un element
              onTap:(){
               Navigator.push(context,
                   MaterialPageRoute(
                       builder:
                       (context)=>GitRepositoryPage
                         (login:items[index]['login'],avatarUrl: items[index]['avatar_url'],
                       )));
              },
              //pour mettre score tt a droite j'envloppe Row dans un autre ROWalors
              title:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:NetworkImage(items[index]['avatar_url']),
                        radius:40,

                      ),
                      //creer un espace entre la photo et login
                      SizedBox(width:20),
                      Text("${items[index]['login']}"),
                    ],
                  ),
                  CircleAvatar(
                    child:Text("${items[index]['score']}"),
                  )
                ],
              ),
            );
            }
        ),
      )
    ],
    )
      )
    );
  }

}