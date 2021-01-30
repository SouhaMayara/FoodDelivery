import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_del/orderDetails.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Orders'),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('FoodOrders').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data.docs.map((document){
              if(document['delivered']=='false'){
                return getCard(context,document);
              }
              else return Center(
                child: null,
              );
            }).toList(),
          );
        },
      )
    );
  }
}

Widget getCard(BuildContext context, item){
  return GestureDetector(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => OrderDetailsPage(foodOrder: item))
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
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(60/2),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://cdn4.iconfinder.com/data/icons/gray-business-2/512/xxx049-512.png'
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                              child: Text(item['owner'],style: TextStyle(fontSize: 17),)
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(item['price'].toString()+'\$',style: TextStyle(color: Colors.grey),),
                              SizedBox(width: 120),
                              Text(item['time'].toString(),style: TextStyle(color: Colors.black),),
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