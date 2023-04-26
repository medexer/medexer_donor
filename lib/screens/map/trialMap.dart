import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapTrial extends StatefulWidget {
  const GoogleMapTrial({Key? key}) : super(key: key);

  @override
  _GoogleMapTrialState createState() => _GoogleMapTrialState();
}

class _GoogleMapTrialState extends State<GoogleMapTrial> {
  Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  final Set<Marker> markers = Set();
  static const LatLng showLocation = LatLng(9.1667,9.7500);
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
          debugPrint('[CONTROLLER]  :: ${controller.runtimeType}');

          setState(() {
            mapController.complete(controller);
          });
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
        position: const LatLng(9.895836673, 8.88430300725),
        infoWindow: const InfoWindow(
            title: 'HOSPITAL3', snippet: 'My customer subtitle'),
        icon: BitmapDescriptor.defaultMarker,
      ));

      markers.add(Marker(
        markerId: MarkerId(showLocation.toString()),
        position: const LatLng(9.8555, 8.8543),
        infoWindow: const InfoWindow(
            title: 'HOSPITAL2', snippet: 'My customer subtitle'),
        icon: BitmapDescriptor.defaultMarker,
      ));

      markers.add(Marker(
        markerId: MarkerId(showLocation.toString()),
        position: const LatLng(9.9394, 8.9022),
        infoWindow: const InfoWindow(
            title: 'Hospital3', snippet: 'My customer subtitle'),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    return markers;
  }
}
