import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_del/cart.dart';
import 'package:food_del/get_menu.dart';
import 'package:food_del/maps.dart';
import 'package:food_del/my_orders.dart';
import 'package:food_del/orders.dart';
import 'package:food_del/services/authentication_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.orange,
            child: Center(
                child: Column(
                  children: <Widget>[
                  Container(
                  width: 90,
                  height: 90,
                  margin: EdgeInsets.only(
                    top: 30,
                    bottom: 10
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://cdn4.iconfinder.com/data/icons/gray-business-2/512/xxx049-512.png'
                      ),
                      fit: BoxFit.fill
                    )
                  ),
                ),
                  Text(user.email, style: TextStyle(fontSize: 18,color: Colors.white))
              ],
            )
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text(
              'My cart',
              style: TextStyle(
                fontSize: 17
              ),
            ),
            onTap: () => {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => Cart()))
            },
          ),
          ListTile(
            leading: Icon(Icons.add_a_photo),
            title: Text(
              'Add Menu',
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            onTap: () => {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => GetMenuPage())
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text(
              'My Menus',
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            onTap: () => {
              /*Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GetMenuPage())
              )*/
            },
          ),
          ListTile(
            leading: Icon(Icons.restaurant_menu),
            title: Text(
              'My Orders',
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyOrdersPage())
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.restaurant_menu),
            title: Text(
              'All Orders',
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            onTap: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrdersPage())
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text(
              'Sign-out',
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            onTap: () => {
              context.read<AuthenticationService>().signOut()
            },
          ),

        ],
      ),
    );
  }
}
