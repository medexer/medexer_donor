import 'package:google_maps_flutter/google_maps_flutter.dart';

class DonationCenterModel {
  String? id;
  int? pkid;
  String? hospitalName;
  String? email;
  String? hospitalID;
  String? location;
  bool? isActive;

  //dummies
  double? lat;
  double? long;

  DonationCenterModel(
      {this.id,
      this.pkid,
      this.hospitalName,
      this.email,
      this.hospitalID,
      this.location,
      this.isActive,
      //dummies
      this.lat,
      this.long,
      });

  DonationCenterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pkid = json['pkid'];
    hospitalName = json['hospitalName'];
    email = json['email'];
    hospitalID = json['hospitalID'];
    location = json['location'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pkid'] = this.pkid;
    data['hospitalName'] = this.hospitalName;
    data['email'] = this.email;
    data['hospitalID'] = this.hospitalID;
    data['location'] = this.location;
    data['is_active'] = this.isActive;
    return data;
  }
}

