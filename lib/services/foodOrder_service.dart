import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_del/model/FoodOrder.dart';

class FoodOrderService {
  final databaseReference = FirebaseFirestore.instance;

  Future <void> createFoodOrder(String id, FoodOrder foodOrder) async{
    databaseReference.collection("FoodOrders").doc(id).set(foodOrder.toMap());
  }

}