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
  HospitalProfile? hospitalProfile;

  DonationCenterModel(
      {this.id,
      this.pkid,
      this.hospitalName,
      this.email,
      this.hospitalID,
      this.isActive,
      this.centerAddress,
      this.inventoryBalance,
      this.centerGeoLocation,
      this.hospitalProfile});

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
    hospitalProfile = json['hospitalProfile'] != null
        ? new HospitalProfile.fromJson(json['hospitalProfile'])
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
    if (this.hospitalProfile != null) {
      data['hospitalProfile'] = this.hospitalProfile!.toJson();
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

class HospitalProfile {
  String? address;
  String? state;
  String? aboutHospital;
  String? cityProvince;
  String? contactNumber;
  String? hospitalImage;
  String? hospitalLogo;

  HospitalProfile(
      {this.address,
      this.state,
      this.aboutHospital,
      this.cityProvince,
      this.contactNumber,
      this.hospitalImage,
      this.hospitalLogo});

  HospitalProfile.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    state = json['state'];
    aboutHospital = json['about_hospital'];
    cityProvince = json['city_province'];
    contactNumber = json['contact_number'];
    hospitalImage = json['hospitalImage'];
    hospitalLogo = json['hospitalLogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['state'] = this.state;
    data['about_hospital'] = this.aboutHospital;
    data['city_province'] = this.cityProvince;
    data['contact_number'] = this.contactNumber;
    data['hospitalImage'] = this.hospitalImage;
    data['hospitalLogo'] = this.hospitalLogo;
    return data;
  }
}
