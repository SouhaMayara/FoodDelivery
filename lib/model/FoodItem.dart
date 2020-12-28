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
  FoodItem(
    id: 3,
    title: "Chili Cheeze Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
    imgUrl: "https://d2vfptrwx1cq2i.cloudfront.net/wp-content/uploads/2020/01/chili-cheese-burger-recipe.jpg",
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
    @required this.id,
    @required this.title,
    @required this.hotel,
    @required this.price,
    @required this.imgUrl,
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