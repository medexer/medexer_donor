// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../database/user_repository.dart';
// import '../../models/mapModel.dart';
// import '../../services/donor_services.dart';


// class FinalMapScreen extends StatefulWidget {
//  // DonationCenterModel donationMap;
//   FinalMapScreen({ Key?  key}) : super(key: key);

//   @override
//   _FinalMapScreenState createState() => _FinalMapScreenState();
// }

// class _FinalMapScreenState extends State<FinalMapScreen> {
//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//   void initMarker(specify, specifyId){
//     var markerIdValue = specifyId;
//     final MarkerId markerId = MarkerId(markerIdValue);
//     final Marker marker = Marker(
//       markerId: markerId,
//       position: LatLng(specify['MapModel'].lat, specify['MapModel'].long),
//       infoWindow: InfoWindow(
//         title: '${specify['MapModel'].hospitalName}', snippet: 'I pray it works'
//       ),
//       ); setState(() {
//         markers[markerId] = marker;
//       });
//   }  

//   getMarkerData()async{
//     if(MapModels.isNotEmpty){
//       for(int index = 0; index<MapModels.length;index++){
//         initMarker(MapModels[index], MapModels[index].hospitalID);
//       }

//     }

//   initState(){
//     getMarkerData();
//     super.initState();
//   }
//   }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   Future<void> requestPermission() async 
//   //   { await Permission.location.request(); }
//   // }

// // Set<Marker>_markers ={};

// // void _onMapCreated(GoogleMapController controller){
// // setState((){
// // 	_markers.add(
// // 	const Marker(
// // 		markerId: MarkerId('id-1'),
// // 		position:LatLng(9.0778,10.6775)	
// // 	    )
// //     );

// //   _markers.add(
// //      const Marker(
// //       markerId:MarkerId('id-2'),
// //       position:LatLng(9.0885,10.6775)
// //     )
// //   );
// //   });
// // }

  

//   @override
//   Widget build(BuildContext context) {
//     // Set<Marker>getMarker(){
//     //   return <Marker>{
//     //     const Marker(
//     //       markerId: MarkerId('shop'),
//     //       position: LatLng(9.0778,10.6775),
//     //       icon: BitmapDescriptor.defaultMarker,
//     //       infoWindow: InfoWindow(
//     //         title: 'Home'
//     //       )
//     //       )
//     //   }.toSet();
//     // }
//     return  Scaffold( 
//        body: GoogleMap(
//         myLocationEnabled: true,
//         mapType: MapType.normal,
//               onMapCreated: (GoogleMapController controller){
//                 controller=controller;
//               },
//               markers: Set<Marker>.of(markers.values),
//               initialCameraPosition: const CameraPosition(
//                 target: LatLng(9.0778,10.6775),
//                 zoom: 15,
//                 )
//           ),
//       );
//   }
// }

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FinalMap extends StatefulWidget {
  const FinalMap({super.key});

  @override
  State<FinalMap> createState() => _FinalMapState();
}

class _FinalMapState extends State<FinalMap> {
  CustomInfoWindowController customInfoWindowcontroller = CustomInfoWindowController();

  final List<Marker>_markers = <Marker>[];
  final List<LatLng>_latlang = [
    const LatLng(9.895725562, 8.98430300725),
    const LatLng(9.895614562, 8.58430300725),
    const LatLng(9.895836673, 8.38430300725)

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMarkers();
  }

  loadMarkers(){
    for(int index=0; index<_latlang.length; index++){
      _markers.add(Marker(
      markerId: MarkerId(index.toString()), 
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: 'hospital 1'
      ),
      position: _latlang[index],
      onTap: (){
        customInfoWindowcontroller.addInfoWindow!(const Text('hooo'),_latlang[index]);
      }
      )
      
      );
      setState(() {
        
      });
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
            scrollGesturesEnabled: true,
            compassEnabled: true,
              myLocationEnabled: true,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller){
                 customInfoWindowcontroller.googleMapController =controller;
                },
              markers: Set<Marker>.of(_markers),
              initialCameraPosition: const CameraPosition(
                target: LatLng(9.0820,8.6753),
                zoom: 15,
                ),
                onTap: (Position){
                  customInfoWindowcontroller.hideInfoWindow;
                },
                onCameraMove: (Position){
                  customInfoWindowcontroller.onCameraMove!();
                },
          ),
          CustomInfoWindow(
            controller: customInfoWindowcontroller,
            height: 200,
            width: 300,
            offset: 35,

            )
      ],
    );
  }
}