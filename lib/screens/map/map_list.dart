import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:medexer_donor/config/app_config.dart';

class GoogleMapList extends StatefulWidget {
  const GoogleMapList({ Key?  key }) : super(key: key);

  @override
  _GoogleMapListState createState() => _GoogleMapListState();
}


class _GoogleMapListState extends State<GoogleMapList> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGoogle =CameraPosition(target: LatLng(37.4279613580664,-12.885749559),
  zoom: 14.4746);

  final List<Marker>_marker = [];
  final List<Marker>_list=const[
    Marker(
      //icon: BitmapDescriptor.defaultMarker,
    //  visible: true,
      markerId: MarkerId('1'),
      position: LatLng(20.42796133580664,80.885749655962),
      infoWindow: InfoWindow(
        title: 'Hospital 1'
        ),
      ),


    Marker(
      visible: true,
      icon: BitmapDescriptor.defaultMarker,
      markerId: MarkerId('2'),
      position: LatLng(25.42796133580664,80.8857496559621),
      infoWindow: InfoWindow(
        title: 'Hospital 2'
      )
      ),

      Marker(
        visible: true,
      markerId: MarkerId('3'),
      //icon: BitmapDescriptor.defaultMarker,
      position: LatLng(25.42796133580664,80.8857496559621),
      infoWindow: InfoWindow(title: 'Hospital 3'),
      
      ),

  ];

  @override
  void initState() {
    super.initState();
    // Future<void> requestPermission() async 
    // { await Permission.location.request(); }
    _marker.addAll(_list);
  }

  

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:EdgeInsets.only(top:5.0.hp),
        child: Container(
          child: GoogleMap(
            initialCameraPosition: _kGoogle,
            mapType: MapType.normal,
            myLocationEnabled: true,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
            ),
    ),
      );
  }
}