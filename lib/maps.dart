import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapsPage extends StatelessWidget {
  final double latitude;
  final double longitude;
  final double myLatitude;
  final double myLongitude;

  MapsPage({Key key, @required this.latitude, @required this.longitude, @required this.myLatitude, @required this.myLongitude}) : super(key: key);

  @override
  Widget build(BuildContext context){
    var points = <LatLng>[
      new LatLng(latitude,longitude),
      new LatLng(35.6333,10.9),
    ];
    return new Scaffold(
        body: new FlutterMap(
            options: new MapOptions(
                center: new LatLng(latitude, longitude), minZoom: 10.0),
            layers: [
              new TileLayerOptions(
                  urlTemplate:
                  "https://api.mapbox.com/styles/v1/amasuo/ckjvcb3f10ihx17o1xr3prwd7/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYW1hc3VvIiwiYSI6ImNranZjMnZndTA3M28ydmxzdnljamNmdGkifQ.HKMAI6yPf8q4exC2OOvBOg",
                  additionalOptions: {
                    'accessToken':
                    'Generated Access token',
                    'id': 'mapbox.mapbox-streets-v7'
                  }),
              new MarkerLayerOptions(
                markers: [
                  new Marker(
                    width: 45.0,
                    height: 45.0,
                    point: new LatLng(latitude, longitude),
                    builder: (context) => new Container(
                      child: IconButton(
                        icon: Icon(Icons.location_on,color: Colors.green),
                        color: Colors.red,
                        iconSize: 45.0,
                      ),
                    )
                  )
                ]
              ),
              new MarkerLayerOptions(
                  markers: [
                    new Marker(
                        width: 45.0,
                        height: 45.0,
                        point: new LatLng(35.6333,10.9),
                        builder: (context) => new Container(
                          child: IconButton(
                            icon: Icon(Icons.location_on,color: Colors.deepPurpleAccent),
                            color: Colors.red,
                            iconSize: 45.0,
                          ),
                        )
                    )
                  ]
              ),
              new PolylineLayerOptions(
                polylines:[
                  new Polyline(
                    points: points,
                    strokeWidth: 3.0,
                    color: Colors.blue
                  )
                ]
              ),
            ])
    );
  }
}
