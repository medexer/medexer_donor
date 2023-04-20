import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapTrial extends StatefulWidget {
  const GoogleMapTrial({Key? key}) : super(key: key);

  @override
  _GoogleMapTrialState createState() => _GoogleMapTrialState();
}

class _GoogleMapTrialState extends State<GoogleMapTrial> {
  Completer<GoogleMapController> mapController = Completer();
  final Set<Marker> markers = Set();
  static const LatLng showLocation = LatLng(27.7089427, 85.3086209);
  // @override
  // void initState() {
  //   super.initState();
  //   Future<void> requestPermission() async
  //   { await Permission.location.request(); }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomGesturesEnabled: true,
        compassEnabled: true,
        initialCameraPosition:
            const CameraPosition(target: showLocation, zoom: 15.0),
        markers: getMarkers(),
        mapType: MapType.normal,
        onMapCreated: ((controller) {
          // setState(() {
          //   mapController = controller as Completer<GoogleMapController>;
          // });
        }),
      ),
    );
  }

  Set<Marker> getMarkers() {
    setState(() {
      markers.add(Marker(
        markerId: MarkerId(showLocation.toString()),
        position: showLocation,
        infoWindow: const InfoWindow(
            title: 'HOSPITAL 1', snippet: 'My customer subtitle'),
        icon: BitmapDescriptor.defaultMarker,
      ));

      markers.add(Marker(
        markerId: MarkerId(showLocation.toString()),
        position: const LatLng(27.7099116, 85.3132343),
        infoWindow: const InfoWindow(
            title: 'HOSPITAL3', snippet: 'My customer subtitle'),
        icon: BitmapDescriptor.defaultMarker,
      ));

      markers.add(Marker(
        markerId: MarkerId(showLocation.toString()),
        position: const LatLng(27.7137735, 85.315626),
        infoWindow: const InfoWindow(
            title: 'Hospita3', snippet: 'My customer subtitle'),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    return markers;
  }
}
