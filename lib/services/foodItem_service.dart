import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_del/model/FoodItem.dart';

class FoodItemService {
  final databaseReference = FirebaseFirestore.instance;

  Future <void> createFoodItem(String id, FoodItem foodItem) async{
    databaseReference.collection("FoodItems").doc(id).set(foodItem.toMap());
  }

}