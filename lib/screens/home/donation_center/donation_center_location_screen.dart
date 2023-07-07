// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
import 'dart:async';
import 'dart:ui' as ui;
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/config/api_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/models/donation_center_model.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/services/donor_services.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import 'package:location/location.dart' as GeoLocation;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class DonationCenterLocationScreen extends StatefulWidget {
  final DonationCenterModel donationCenter;
  const DonationCenterLocationScreen({super.key, required this.donationCenter});

  @override
  State<DonationCenterLocationScreen> createState() =>
      _DonationCenterLocationScreenState();
}

class _DonationCenterLocationScreenState
    extends State<DonationCenterLocationScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final DonorServices donorServices = Get.find();
  final UserRepository userRepository = Get.find();
  CustomInfoWindowController customInfoWindowcontroller =
      CustomInfoWindowController();
  Set<Marker> markers = {};
  late BitmapDescriptor markerIcon;
  GeoLocation.LocationData? currentLocation;
  late bool _serviceEnabled;
  late GeoLocation.PermissionStatus _permissionGranted;
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polylineCoordinates = [];

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

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
    userRepository.currentUserLatitude.value = currentLocation!.latitude!;
    userRepository.currentUserLongitude.value = currentLocation!.longitude!;

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLoc) {
      setState(() {
        // googleMapController
        //     .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        //         zoom: 12,
        //         target: LatLng(newLoc.latitude!, newLoc.longitude!))));
        currentLocation = newLoc;
        userRepository.currentUserLatitude.value = newLoc.latitude!;
        userRepository.currentUserLongitude.value = newLoc.longitude!;
      });
    });
  }

  Future<void> getPolyPoints() async {
    // await Future.delayed(const Duration(seconds: 1));

    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyDUtLQoVhaoIl0l6K_Cy1yfWWX1XkwaQCk",
        PointLatLng(userRepository.currentUserLatitude.value,
            userRepository.currentUserLongitude.value),
        PointLatLng(widget.donationCenter.centerGeoLocation!.lat!,
            widget.donationCenter.centerGeoLocation!.lng!));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {
        userRepository.hospitalRouteAdded.value = true;
      });

      print('[ROUTE] :: $polylineCoordinates');
    }
  }

  Future<void> onMapCreated() async {
    final Uint8List myMarkerIcon =
        await getBytesFromAsset('assets/icons/icon__marker__3.png', 60);

    final Uint8List markerIcon =
        await getBytesFromAsset('assets/icons/icon__marker__2.png', 60);

    setState(() {
      markers.add(
        Marker(
          icon: BitmapDescriptor.fromBytes(markerIcon),
          markerId: MarkerId('${widget.donationCenter.pkid}'),
          position: LatLng(widget.donationCenter.centerGeoLocation!.lat!,
              widget.donationCenter.centerGeoLocation!.lng!),
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
                      decoration: BoxDecoration(
                        image: widget.donationCenter.hospitalProfile!
                                    .hospitalImage !=
                                null
                            ? DecorationImage(
                                image: NetworkImage(
                                    '${APIConstants.backendServerRootUrl}${widget.donationCenter.hospitalProfile!.hospitalImage}'),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              )
                            : const DecorationImage(
                                image:
                                    AssetImage('assets/images/hospital__2.jpg'),
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
                            text: '${widget.donationCenter.hospitalName}',
                            size: 14.0.sp,
                          ),
                          CustomTextWidget(
                            text: '${widget.donationCenter.centerAddress}',
                            size: 10.0.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              LatLng(widget.donationCenter.centerGeoLocation!.lat!,
                  widget.donationCenter.centerGeoLocation!.lng!),
            );
          },
        ),
      );
    });

    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      markers.add(Marker(
        icon: BitmapDescriptor.fromBytes(myMarkerIcon),
        markerId: MarkerId('${userRepository.userData.value.donorID}'),
        position: currentLocation != null
            ? LatLng(userRepository.currentUserLatitude.value,
                userRepository.currentUserLongitude.value)
            : LatLng(9.906587499999999, 8.9547031),
      ));
    });
  }

  void initializeMapFunctions() async {
    await initializeCurrentLocation();
    await getPolyPoints();
    await onMapCreated();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initializeMapFunctions();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        userRepository.hospitalRouteAdded.value = false;

        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: SideBar(),
        appBar: AppBar(
          // leading: Icon(Icons.arrow_back_ios),
          backgroundColor: AppStyles.bgPrimary,
          title: CustomTextWidget(
            text: '${widget.donationCenter.hospitalName} Location',
            size: 12.0.sp,
          ),
        ),
        body: Obx(
          () => SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    userRepository.hospitalRouteAdded.value == true
                        ? SizedBox(height: 2.0.hp)
                        : SizedBox(height: 2.0.hp),
                    GoogleMap(
                      polylines: {
                        Polyline(
                            polylineId: PolylineId('route'),
                            points: polylineCoordinates,
                            color: AppStyles.bgBlue,
                            width: 4),
                      },
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                        new Factory<OneSequenceGestureRecognizer>(
                          () => new EagerGestureRecognizer(),
                        ),
                      ].toSet(),
                      scrollGesturesEnabled: true,
                      compassEnabled: true,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                        customInfoWindowcontroller.googleMapController =
                            controller;

                        // initializeMarkerIcon();
                      },
                      // markers: _markers!,
                      markers: markers,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              widget.donationCenter.centerGeoLocation!.lat!,
                              widget.donationCenter.centerGeoLocation!.lng!),
                          zoom: 13.5),
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
                    ),
                    // Positioned(
                    //   top: 0,
                    //   width: screenWidth,
                    //   child: PageHeader(scaffoldKey: scaffoldKey),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
