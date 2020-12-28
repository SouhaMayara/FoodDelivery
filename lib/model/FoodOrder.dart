import 'package:flutter/cupertino.dart';
import 'package:food_del/model/FoodItem.dart';
import 'dart:developer';


class FoodOrder{
  int id;
  List<FoodItem> foodItems;
  String price;
  String owner;
  String address;

  FoodOrder({
    @required this.id,
    @required this.foodItems,
    @required this.price,
    @required this.owner
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
      'owner' : owner
    };
  }
}