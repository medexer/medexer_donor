import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:medexer_donor/config/app_config.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({ Key?  key }) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}


class _GoogleMapScreenState extends State<GoogleMapScreen> {

  @override
  void initState() {
    super.initState();
    Future<void> requestPermission() async 
    { await Permission.location.request(); }
  }

Set<Marker>_markers ={};

void _onMapCreated(GoogleMapController controller){
setState((){
	_markers.add(
	const Marker(
		markerId: MarkerId('id-1'),
		position:LatLng(9.0778,10.6775)	
	    )
    );

  _markers.add(
     const Marker(
      markerId:MarkerId('id-2'),
      position:LatLng(9.0885,10.6775)
    )
  );
  });
}

  

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:EdgeInsets.only(top:5.0.hp),
        child: ListView(
          children:[
            SizedBox(
              height: 500,
              child: GoogleMap(
              myLocationEnabled: true,
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              markers: _markers,
              initialCameraPosition: const CameraPosition(
                target: LatLng(9.0778,10.6775),
                zoom: 15,
                )
          ),
            ),
          ], 
        //)
    ),
      );
  }
}