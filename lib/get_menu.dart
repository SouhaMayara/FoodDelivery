import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_del/services/foodItem_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_del/model/FoodItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;


class GetMenuPage extends StatefulWidget {
  @override
  _GetMenuPageState createState() => _GetMenuPageState();
}

class _GetMenuPageState extends State<GetMenuPage> {
  File pickedImage;
  var imageFile;
  bool isImageLoaded = false;

  getImageFromGallery() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);

    imageFile = await tempStore.readAsBytes();
    imageFile = await decodeImageFromList(imageFile);

    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;

      imageFile = imageFile;
    });
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  readTextfromanImage() async {
    List<FoodItem> l = List<FoodItem>();
    FirebaseVisionImage myImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(myImage);


    int i = 0;
    String title;
    double price;
    FoodItem f = new FoodItem();
    for (TextBlock block in readText.blocks) {
      if(block.text!='BURGERS'){
        if (block.text.contains("BURGER")) {
          i++;
          title=block.text;
        }
        if (isNumeric(block.text)){
          i++;
          price = double.parse(block.text);
        }
        if(i==2){
          f.title = title;
          f.price = price;
          developer.log(f.toMap().toString()+"aaaaaaaaaaaa");
          await storeFoodItem(f);
          l.add(f);
          i=0;
        }
      }
    }
  }

  storeFoodItem(FoodItem f) async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    FoodItemService foodItemService = new FoodItemService();
    final QuerySnapshot qSnap = await FirebaseFirestore.instance.collection('FoodItems').get();
    int n = qSnap.size;
    FoodItem foodItem = new FoodItem(id:n+1, title: f.title,hotel: user.email ,price: f.price, imgUrl: 'https://cdn.iconscout.com/icon/premium/png-256-thumb/burger-1968268-1667350.png');
    foodItemService.createFoodItem((n+1).toString(), foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Menu'),
        actions: [
          RaisedButton(
            onPressed: getImageFromGallery,
            child: Icon(
              Icons.add_a_photo,
              color: Colors.white,
            ),
            color: Colors.orange,
          )
        ],
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          SizedBox(height: 100),
          isImageLoaded
              ? Center(
            child: Container(
              height: 250.0,
              width: 250.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(pickedImage), fit: BoxFit.cover)),
            ),
          )
              : Container(),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(''),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          readTextfromanImage();
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.check),
      ),
    );
  }
}