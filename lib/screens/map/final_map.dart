import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/models/donation_center_geodata_model.dart';
import 'package:medexer_donor/screens/home/donation_center/hospital_map_donation_center_profile_screen.dart';
import 'package:medexer_donor/services/donor_services.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class FinalMap extends StatefulWidget {
  const FinalMap({super.key});

  @override
  State<FinalMap> createState() => _FinalMapState();
}

class _FinalMapState extends State<FinalMap> {
  Set<Marker> markers = {};
  final Set<Polyline> _polyLines = {};
  final DonorServices donorServices = Get.find();
  final UserRepository userRepository = Get.find();
  CustomInfoWindowController customInfoWindowcontroller =
      CustomInfoWindowController();

  Future onMapcreated() async {
    donorServices.fetchDontationCentersGeoDataController();
    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      for (DonationCenterGeoDataModel location
          in userRepository.donationCentersGeoData) {
        // print('LOC :: ${location.location!.lat}');
        markers.add(
          Marker(
              markerId: MarkerId('${location.centerName}'),
              position:
                  LatLng(location.location!.lat!, location.location!.lng!),
              onTap: () {
                customInfoWindowcontroller.addInfoWindow!(
                  Container(
                    height: 25.0.hp,
                    decoration: BoxDecoration(
                      color: AppStyles.bgWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 12.0.hp,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/hospital__1.jpg'),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                        Container(
                          // height: 15.0.hp,
                          padding: EdgeInsets.symmetric(
                            vertical: 1.0.hp,
                            horizontal: 2.0.wp,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                text: '${location.centerName}',
                                size: 14.0.sp,
                              ),
                              CustomTextWidget(
                                text: '${location.address}',
                                size: 10.0.sp,
                              ),
                              SizedBox(height: 1.0.hp),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomButton(
                                    text: 'Profile',
                                    width: 30.0.wp,
                                    height: 4.0.hp,
                                    onTapHandler: () {
                                      Get.to(
                                        () =>
                                            HospitalMapDonationCenterProfileScreen(
                                                donationCenter: location),
                                      );

                                      customInfoWindowcontroller
                                          .hideInfoWindow!();
                                    },
                                    fontSize: 10.0.sp,
                                    borderRadius: 5,
                                    fontColor: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    backgroundColor: AppStyles.bgBlue,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  LatLng(location.location!.lat!, location.location!.lng!),
                );
              }),
        );
      }
      // print('[GEODATA] :: ${userRepository.donationCentersGeoData}');
    });
  }

  @override
  void initState() {
    super.initState();

    onMapcreated();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          polylines: _polyLines,
          scrollGesturesEnabled: true,
          compassEnabled: true,
          myLocationEnabled: true,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            customInfoWindowcontroller.googleMapController = controller;

            // onMapcreated();
          },
          // markers: _markers!,
          markers: markers,
          initialCameraPosition: const CameraPosition(
            target: LatLng(9.906587499999999, 8.9547031),
            zoom: 10,
          ),
          onTap: (Position) {
            customInfoWindowcontroller.hideInfoWindow!();
          },
          onCameraMove: (Position) {
            customInfoWindowcontroller.onCameraMove!();
          },
        ),
        CustomInfoWindow(
          controller: customInfoWindowcontroller,
          height: 25.0.hp,
          width: 300,
          offset: 35,
        )
      ],
    );
  }
}
