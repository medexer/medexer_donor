class DonationCenterModel {
  String? id;
  int? pkid;
  String? hospitalName;
  String? email;
  String? hospitalID;
  bool? isActive;
  String? centerAddress;
  int? inventoryBalance;
  CenterGeoLocation? centerGeoLocation;

  DonationCenterModel(
      {this.id,
      this.pkid,
      this.hospitalName,
      this.email,
      this.hospitalID,
      this.isActive,
      this.centerAddress,
      this.inventoryBalance,
      this.centerGeoLocation});

  DonationCenterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pkid = json['pkid'];
    hospitalName = json['hospitalName'];
    email = json['email'];
    hospitalID = json['hospitalID'];
    isActive = json['is_active'];
    centerAddress = json['centerAddress'];
    inventoryBalance = json['inventoryBalance'];
    centerGeoLocation = json['centerGeoLocation'] != null
        ? new CenterGeoLocation.fromJson(json['centerGeoLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pkid'] = this.pkid;
    data['hospitalName'] = this.hospitalName;
    data['email'] = this.email;
    data['hospitalID'] = this.hospitalID;
    data['is_active'] = this.isActive;
    data['centerAddress'] = this.centerAddress;
    data['inventoryBalance'] = this.inventoryBalance;
    if (this.centerGeoLocation != null) {
      data['centerGeoLocation'] = this.centerGeoLocation!.toJson();
    }
    return data;
  }
}

class CenterGeoLocation {
  double? lat;
  double? lng;

  CenterGeoLocation({this.lat, this.lng});

  CenterGeoLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
