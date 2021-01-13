import 'package:flutter/cupertino.dart';
import 'package:food_del/model/FoodItem.dart';
import 'dart:developer';


class FoodOrder{
  int id;
  List<FoodItem> foodItems;
  String price;
  String owner;
  String address;
  String date;
  String time;
  double latitude;
  double longitude;
  String delivered;

  FoodOrder({
    @required this.id,
    @required this.foodItems,
    @required this.price,
    @required this.owner,
    @required this.date,
    @required this.time,
    @required this.latitude,
    @required this.longitude,
    @required this.delivered
  });

  Map<String,dynamic> toMap(){
    List<String> foodI = new List<String>();
    for(FoodItem f in this.foodItems){
      log(f.toMap().toString());
      foodI.add(f.toMap().toString());
    }
    return {
      'id': id,
      'foodItems': foodI,
      'price': price,
      'owner' : owner,
      'date' : date,
      'time' : time,
      'latitude': latitude,
      'longitude': longitude,
      'delivered': delivered,
    };
  }
}