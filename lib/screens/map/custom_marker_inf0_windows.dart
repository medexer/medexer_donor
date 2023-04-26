import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:medexer_donor/config/app_config.dart';

import '../../database/user_repository.dart';
import '../../services/donor_services.dart';
import '../../widgets/text/custom_text_widget.dart';
import '../home/route_screen.dart';
import '../home/sidebar.dart';

class CustomMapInfoWindow extends StatefulWidget {
  const CustomMapInfoWindow({super.key});

  @override
  State<CustomMapInfoWindow> createState() => _CustomMapInfoWindowState();
}

class _CustomMapInfoWindowState extends State<CustomMapInfoWindow> {
 final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  Completer<GoogleMapController> mapController =Completer<GoogleMapController>();
 GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
 final UserRepository userRepository = Get.find();
final DonorServices donorServices = Get.put(DonorServices());
  static const LatLng showLocation = LatLng(9.896527, 8.858331);
  //final double _zoom = 15.0;

  @override
  void initState() {
    super.initState();
    donorServices.fetchAppointmentsController();
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  //Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Obx(()=>
       Scaffold(
        key: scaffoldKey,
        drawer: const SideBar(),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
            height: 12.0.hp,
            child: Column(
              children: [
                SizedBox(height: 1.0.hp),
                Center(
                  child: Container(
                    width: 40,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppStyles.bgGray.withOpacity(0.5),
                    ),
                  ),
                ),
                SizedBox(height: 2.0.hp),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      transition: Transition.downToUp,
                      duration: const Duration(milliseconds: 500),
                      () => const RouteScreen(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 1.2.hp,
                      horizontal: 2.0.wp,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppStyles.bgGray.withOpacity(0.2),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        CustomTextWidget(
                          text: 'Search for a Donation Center',
                          size: 14.0.sp,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            height: screenHeight,
            width: screenWidth,
            child: Stack(
              children: <Widget>[
                donorServices.donorRequestLoading.value == true
                ? const Center(
                  child: CircularProgressIndicator())
                :ListView.builder(
                  itemCount: userRepository.appointments.length,
                  itemBuilder: (context, index) {
                  return GoogleMap(
                    mapType: MapType.normal,
                    onMapCreated: ((controller) {
                      debugPrint('[CONTROLLER]  :: ${controller.runtimeType}');
    
                        setState(() {
                        mapController.complete(controller);
                        });
                    }),
                    mapToolbarEnabled: true,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    compassEnabled: true,
                    onTap: (position) {
                      _customInfoWindowController.hideInfoWindow!();
                    },
                    onCameraMove: (position) {
                      _customInfoWindowController.onCameraMove!();
                    },
                    // onMapCreated: (GoogleMapController controller) async {
                    //   _customInfoWindowController.googleMapController = controller;
                    // },
                    markers: {
                      Marker(
                        markerId: const MarkerId("marker_id"),
                        position: const LatLng(9.895836673, 8.88430300725),
                        onTap: () {
                          _customInfoWindowController.addInfoWindow!(
                            Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.local_hospital_outlined,
                                        color: Colors.red,
                                        size: 30,
                                        ),
                                      const SizedBox(
                                        width: 8.0,
                                       ),
                                       CustomTextWidget(
                                        text:'${userRepository.appointments[index].hospitalInfo.hospitalName}'
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.blue,
                                  width: 20.0,
                                  height: 10.0,
                                ), 
                              ],
                            ),
                          const LatLng(9.895836673, 8.88430300725)
                        );
                      },
                      ),
                    },
                    initialCameraPosition:const CameraPosition(target: showLocation, zoom: 15.0),
                  );
                  }
                ),
                CustomInfoWindow(
                  controller: _customInfoWindowController,
                  height: 75,
                  width: 150,
                  offset: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}