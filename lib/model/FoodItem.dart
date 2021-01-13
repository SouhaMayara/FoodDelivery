import 'dart:core';

import 'package:flutter/foundation.dart';

FooditemList fooditemList = FooditemList(foodItems: [
  FoodItem(
    id: 1,
    title: "Beach BBQ Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
    imgUrl:
    "https://hips.hearstapps.com/pop.h-cdn.co/assets/cm/15/05/480x240/54ca71fb94ad3_-_5summer_skills_burger_470_0808-de.jpg",
  ),
  FoodItem(
    id: 2,
    title: "Cheese Burger",
    hotel: "Golf Course",
    price: 8.49,
    imgUrl: "https://www.tacos-avenue.com/wp-content/uploads/2016/11/cheese-burger.jpg",
  ),
]);

class FooditemList {
  List<FoodItem> foodItems;

  FooditemList({@required this.foodItems});
}

class FoodItem {
  int id;
  String title;
  String hotel;
  double price;
  String imgUrl;
  int quantity;

  FoodItem({
    this.id,
    this.title,
    this.hotel,
    this.price,
    this.imgUrl,
    this.quantity = 1,
  });

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }

  factory FoodItem.fromJson(Map<String, dynamic> json){
    return FoodItem(
        id: json['id'],
        title: json['title'],
        hotel: json['hotel'],
        price: json['price'],
        imgUrl: json['imgUrl']);
  }

  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'hotel': hotel,
      'price': price,
      'imgUrl': imgUrl
    };
  }
}