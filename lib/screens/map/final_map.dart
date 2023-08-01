// ignore_for_file: unnecessary_new, prefer_collection_literals, prefer_const_constructors
import 'dart:ui' as ui;
import 'dart:convert';
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
import 'package:medexer_donor/services/auth_services.dart';
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
  final AuthServices authServices = Get.find();
  final UserRepository userRepository = Get.find();
  CustomInfoWindowController customInfoWindowcontroller =
      CustomInfoWindowController();
  GeoLocation.LocationData? currentLocation;
  late bool _serviceEnabled;
  late GeoLocation.PermissionStatus _permissionGranted;
  final Completer<GoogleMapController> _controller = Completer();

  Future<void> initializeCurrentLocation() async {
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
    await authServices.updateProfileLocationController({
      "latitude": currentLocation!.latitude,
      "longitude": currentLocation!.longitude,
    });
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 13,
          target:
              LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        ),
      ),
    );

    location.onLocationChanged.listen((newLoc) {
      setState(() {
        currentLocation = newLoc;
      });

      if (currentLocation!.latitude != newLoc.latitude) {
        authServices.updateProfileLocationController({
          "latitude": newLoc.latitude,
          "longitude": newLoc.longitude,
        });

        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13,
              target: LatLng(newLoc.latitude!, newLoc.longitude!),
            ),
          ),
        );
      }
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
    await donorServices.fetchDontationCentersGeoDataController();

    final Uint8List myMarkerIcon = await getBytesFromAsset(
        path: 'assets/icons/icon__marker__3.png', width: 60);

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
                    height: MediaQuery.of(context).size.height * 0.3,
                    // height: 25.0.hp,
                    decoration: BoxDecoration(
                      color: AppStyles.bgWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // height: 18.0.hp,
                          height: MediaQuery.of(context).size.height * 0.18,
                          // width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: NetworkImage('${location.hospitalImage}'),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                            // image: DecorationImage(
                            //   image:
                            //       AssetImage('assets/images/hospital__1.jpg'),
                            //   fit: BoxFit.cover,
                            //   filterQuality: FilterQuality.high,
                            // ),
                          ),
                        ),
                        Container(
                          // height: 15.0.hp,
                          height: MediaQuery.of(context).size.height * 0.12,
                          padding: EdgeInsets.only(
                            top: 1.0.hp,
                            left: 2.0.wp,
                            right: 2.0.wp,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                text: '${location.centerName}',
                                size: 16.0,
                              ),
                              CustomTextWidget(
                                text: '${location.address}',
                                size: 14.0,
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

    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      markers.add(Marker(
        icon: BitmapDescriptor.fromBytes(myMarkerIcon),
        markerId: MarkerId('${userRepository.userData.value.donorID}'),
        position: currentLocation != null
            ? LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
            : LatLng(9.906587499999999, 8.9547031),
      ));
    });
  }

  void changeMapMode(GoogleMapController mapController) {
    getJsonFile("assets/json/map_style_1.json")
        .then((value) => setMapStyle(value, mapController));
  }

  //helper function
  void setMapStyle(String mapStyle, GoogleMapController mapController) {
    mapController.setMapStyle(mapStyle);
  }

  //helper function
  Future<String> getJsonFile(String path) async {
    ByteData byte = await rootBundle.load(path);
    var list = byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes);
    return utf8.decode(list);
  }

  void initializeMapFunctions() async {
    await initializeCurrentLocation();
    await onMapcreated();
  }

  @override
  void initState() {
    super.initState();

    initializeMapFunctions();
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
            _controller.complete(controller);
            customInfoWindowcontroller.googleMapController = controller;

            // changeMapMode(controller);
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
            zoom: 13,
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
          // height: 28.0.hp,
          height: MediaQuery.of(context).size.height * 0.3,
          width: 300,
          offset: 35,
        )
      ],
    );
  }
}
