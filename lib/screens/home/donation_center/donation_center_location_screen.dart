// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
import 'dart:ui' as ui;
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/models/donation_center_model.dart';
import 'package:medexer_donor/services/donor_services.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class DonationCenterLocationScreen extends StatefulWidget {
  final DonationCenterModel donationCenter;
  const DonationCenterLocationScreen({super.key, required this.donationCenter});

  @override
  State<DonationCenterLocationScreen> createState() =>
      _DonationCenterLocationScreenState();
}

class _DonationCenterLocationScreenState
    extends State<DonationCenterLocationScreen> {
  final Set<Polyline> _polyLines = {};
  final DonorServices donorServices = Get.find();
  final UserRepository userRepository = Get.find();
  CustomInfoWindowController customInfoWindowcontroller =
      CustomInfoWindowController();
  Set<Marker> markers = {};
  late BitmapDescriptor markerIcon;
  BitmapDescriptor initialmarkerIcon = BitmapDescriptor.defaultMarker;

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void initializeMarkerIcon() async {
    await getBytesFromAsset('assets/icons/icon__marker__1.png', 110)
        .then((onValue) {
      setState(() {
        markerIcon = BitmapDescriptor.fromBytes(onValue);
      });
    });

    markers.add(
      Marker(
        // icon: markerIcon,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppStyles.bgBlue,
      // ),
      body: Stack(
        children: [
          GoogleMap(
            polylines: _polyLines,
            scrollGesturesEnabled: true,
            compassEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              customInfoWindowcontroller.googleMapController = controller;

              initializeMarkerIcon();
            },
            // markers: _markers!,
            markers: markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.donationCenter.centerGeoLocation!.lat!,
                  widget.donationCenter.centerGeoLocation!.lng!),
              zoom: 12,
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
      ),
    );
  }
}
