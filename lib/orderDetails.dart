import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_del/maps.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:geolocator/geolocator.dart';

class OrderDetailsPage extends StatelessWidget {
  final QueryDocumentSnapshot foodOrder;

  OrderDetailsPage({Key key, @required this.foodOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Position p = new Position();
    return Scaffold(
      appBar: AppBar(
        title: Text(foodOrder['owner']+'\'s order'),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        children: [
          Card(
              elevation: 1.5,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                      title: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => MapsPage(latitude: foodOrder['latitude'],longitude: foodOrder['longitude'], myLatitude: position.latitude, myLongitude: position.longitude))
                              );
                            },
                            child: Container(
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
                            )
                          ),
                          SizedBox(width: 20,),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                    child: Text('Delivered',style: TextStyle(fontSize: 17),)
                                ),
                                SizedBox(width: 15),
                                LiteRollingSwitch(
                                  value: false,
                                  textOn: 'Yes',
                                  textOff: 'No',
                                  colorOn: Colors.greenAccent,
                                  colorOff: Colors.grey,
                                  iconOff: Icons.block,
                                  onChanged: (bool delivered){
                                    if(delivered){
                                      FirebaseFirestore.instance.collection("FoodOrders").doc(foodOrder['id'].toString()).update({"delivered" : "true"}).then((value) => "updated delivered true");
                                    }
                                    if(!delivered){
                                      FirebaseFirestore.instance.collection("FoodOrders").doc(foodOrder['id'].toString()).update({"delivered" : "false"}).then((value) => "updated delivered false");
                                    }
                                  },
                                ),
                              ]
                          ),
                        ],
                      )
                  )
              )
          ),
        ],
      ),
    );
  }
}
