
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';

import '../../database/user_repository.dart';
import '../../services/donor_services.dart';

class CustomInfoWindowExample extends StatefulWidget {
   const CustomInfoWindowExample({super.key});

  @override
  _CustomInfoWindowExampleState createState() =>
      _CustomInfoWindowExampleState();
}

class _CustomInfoWindowExampleState extends State<CustomInfoWindowExample> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
          final UserRepository userRepository = Get.find();
  final DonorServices donorServices = Get.put(DonorServices());

  final LatLng _latLng = const LatLng(9.1667,9.7500);
  final double _zoom = 15.0;

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    // _markers.add(
    //   Marker(
    //     markerId: MarkerId("marker_id"),
    //     position: _latLng,
    //     onTap: () {
    //       _customInfoWindowController.addInfoWindow!(
    //         Column(
    //           children: [
    //             Expanded(
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                   color: Colors.blue,
    //                   borderRadius: BorderRadius.circular(4),
    //                 ),
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Icon(
    //                         Icons.account_circle,
    //                         color: Colors.white,
    //                         size: 30,
    //                       ),
    //                       SizedBox(
    //                         width: 8.0,
    //                       ),
    //                       Text(
    //                         '${userRepository.appointments[index].hospitalInfo.hospitalName}',
    //                         style:
    //                             Theme.of(context).textTheme.headline6!.copyWith(
    //                                   color: Colors.white,
    //                                 ),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //                 width: double.infinity,
    //                 height: double.infinity,
    //               ),
    //             ),
                
    //              Container(
    //                 color: Colors.blue,
    //                 width: 20.0,
    //                 height: 10.0,
    //               ),
    //           ],
    //         ),
    //         _latLng,
    //       );
    //     },
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Info Window Example'),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) async {
              _customInfoWindowController.googleMapController = controller;
            },
            markers: {
              Marker(
        markerId: MarkerId("marker_id"),
        position: _latLng,
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "I am here",
                            // style:
                            //     Theme.of(context).textTheme.headline6!.copyWith(
                            //           color: Colors.white,
                            //         ),
                          )
                        ],
                      ),
                    ),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                
                 Container(
                    color: Colors.blue,
                    width: 20.0,
                    height: 10.0,
                  ),
              ],
            ),
            _latLng,
          );
        },
      ),
    
            },
            initialCameraPosition: CameraPosition(
              target: _latLng,
              zoom: _zoom,
            ),
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 75,
            width: 150,
            offset: 50,
          ),
        ],
      ),
    );
  }
}