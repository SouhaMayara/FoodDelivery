import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_del/menu_item.dart';

class MyMenuPage extends StatefulWidget {
  @override
  _MyMenuPageState createState() => _MyMenuPageState();
}

class _MyMenuPageState extends State<MyMenuPage> {

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    return Scaffold(
        appBar: AppBar(
          title: Text('My Menu'),
          backgroundColor: Colors.orange,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('FoodItems').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data.docs.map((document){
                if(document['hotel']==user.email){
                  return getCard(context,document);
                }
                else return Center(
                  child: null,
                );
              }).toList(),
            );
          },
        )
    ); /**/
  }
}

String getImage(item){
  if(item['imgUrl'] == null){
    return 'https://cdn.iconscout.com/icon/premium/png-256-thumb/burger-1968268-1667350.png';
  }
    return item['imgUrl'];

}
Widget getCard(BuildContext context, item){
  return GestureDetector(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MenuItemPage(foodItem: item))
      );
    },
    child: Card(
        elevation: 1.5,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
                title: Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60/2),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              getImage(item)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                              child: Text(item['title'],style: TextStyle(fontSize: 17),)
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(item['price'].toString()+'\$',style: TextStyle(color: Colors.grey),),
                              SizedBox(width: 100),
                              Text(item['hotel'].toString(),style: TextStyle(color: Colors.black),),
                            ],
                          ),
                        ]
                    ),
                  ],
                )
            )
        )
    ),
  );
}