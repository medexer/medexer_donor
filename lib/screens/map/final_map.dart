// ignore_for_file: unnecessary_new, prefer_collection_literals, prefer_const_constructors
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
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
import 'package:location/location.dart' as GeoLocation;

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
  GeoLocation.LocationData? currentLocation;
  late bool _serviceEnabled;
  late GeoLocation.PermissionStatus _permissionGranted;

  void initializeCurrentLocation() async {
    GeoLocation.Location location = GeoLocation.Location();
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == GeoLocation.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != GeoLocation.PermissionStatus.granted) {
        return;
      }
    }

    currentLocation = await location.getLocation();

    location.onLocationChanged.listen((newLoc) {
      setState(() {
        currentLocation = newLoc;
      });
    });
  }

  Future<Uint8List> getBytesFromAsset(
      {required String path, required int width}) async {
    final ByteData _data = await rootBundle.load(path);
    final ui.Codec _codec = await ui
        .instantiateImageCodec(_data.buffer.asUint8List(), targetWidth: width);
    final ui.FrameInfo _fi = await _codec.getNextFrame();
    final Uint8List _bytes =
        (await _fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();
    return _bytes;
  }

  Future onMapcreated() async {
    donorServices.fetchDontationCentersGeoDataController();

    final Uint8List myMarkerIcon = await getBytesFromAsset(
        path: 'assets/icons/icon__marker__3.png', width: 60);

    setState(() {
      markers.add(Marker(
        icon: BitmapDescriptor.fromBytes(myMarkerIcon),
        markerId: MarkerId('${userRepository.userData.value.donorID}'),
        position: currentLocation != null
            ? LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
            : LatLng(9.906587499999999, 8.9547031),
      ));
    });

    await Future.delayed(const Duration(seconds: 3));

    final Uint8List markerIcon = await getBytesFromAsset(
        path: 'assets/icons/icon__marker__2.png', width: 60);

    setState(() {
      for (DonationCenterGeoDataModel location
          in userRepository.donationCentersGeoData) {
        // print('LOC :: ${location.location!.lat}');
        markers.add(
          Marker(
              icon: BitmapDescriptor.fromBytes(markerIcon),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 12.0.hp,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/hospital__1.jpg'),
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
    });
  }

  @override
  void initState() {
    super.initState();

    initializeCurrentLocation();
    onMapcreated();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
            new Factory<OneSequenceGestureRecognizer>(
              () => new EagerGestureRecognizer(),
            ),
          ].toSet(),
          polylines: _polyLines,
          scrollGesturesEnabled: true,
          compassEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            customInfoWindowcontroller.googleMapController = controller;

            // onMapcreated();
          },
          // markers: _markers!,
          markers: markers,
          initialCameraPosition: CameraPosition(
            target: currentLocation != null
                ? LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!)
                : LatLng(9.906587499999999, 8.9547031),
            // zoom: 10,
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
          height: 28.0.hp,
          width: 300,
          offset: 35,
        )
      ],
    );
  }
}
