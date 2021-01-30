import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class MenuItemPage extends StatefulWidget {
  final QueryDocumentSnapshot foodItem;

  MenuItemPage({Key key, @required this.foodItem}) : super(key: key);

  @override
  _MenuItemPageState createState() => _MenuItemPageState(foodItem);
}

class _MenuItemPageState extends State<MenuItemPage> {
  bool imgpicked=false;
  File _image;
  String imageUrl;
  QueryDocumentSnapshot foodItem;
  TextEditingController burgerNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  _MenuItemPageState(QueryDocumentSnapshot foodItem){
    this.foodItem = foodItem;
    burgerNameController.text= foodItem['title'];
    priceController.text = foodItem['price'].toString();
  }

  String getImageFromFireBase(item){
    if(item['imgUrl'] == null){
      return 'https://cdn.iconscout.com/icon/premium/png-256-thumb/burger-1968268-1667350.png';
    }
    return foodItem['imgUrl'];
  }

  @override
  Widget build(BuildContext context) {

    Future getImage() async {
      // ignore: deprecated_member_use
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        imgpicked=true;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async{
      if(imgpicked){
        String fileName = basename(_image.path);
        Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
        UploadTask uploadTask = firebaseStorageRef.putFile(_image);
        var dowurl=await (await uploadTask).ref.getDownloadURL();

        setState(() {
          print("Picture uploaded");
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Picture Uploaded')));
        });
        FirebaseFirestore.instance.collection("FoodItems").doc(foodItem['id'].toString()).update({"imgUrl" : dowurl});
      }
      FirebaseFirestore.instance.collection("FoodItems").doc(foodItem['id'].toString()).update({"title" : burgerNameController.text});
      FirebaseFirestore.instance.collection("FoodItems").doc(foodItem['id'].toString()).update({"price" : int.parse(priceController.text)});
    }

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(foodItem['title']),
          backgroundColor: Colors.orange,
      ),
      body: Builder(
        builder: (context) =>  Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: new SizedBox(
                          width: 180.0,
                          height: 180.0,
                          child: (_image!=null)?Image.file(
                            _image,
                            fit: BoxFit.fill,
                          ):Image.network(
                            getImageFromFireBase(foodItem),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 60.0),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.camera,
                        size: 30.0,
                      ),
                      onPressed: () {
                        getImage();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Burger name',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18.0)),
                          ),
                          Container(
                            width: 170,
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                            ),
                            child: TextField(
                              controller: burgerNameController,
                              decoration: InputDecoration(
                                  hintText: foodItem['title'],
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Icon(
                        FontAwesomeIcons.pen,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Price',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18.0)),
                          ),
                          Container(
                            width: 170,
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                            ),
                            child: TextField(
                              controller: priceController,
                              decoration: InputDecoration(
                                  hintText: foodItem['price'].toString(),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Icon(
                        FontAwesomeIcons.pen,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Owner',
                        style:
                        TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
                    SizedBox(width: 50.0),
                    Text(foodItem['hotel'],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.orange,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.orange,
                    onPressed: () {
                      uploadPic(context);
                    },

                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}