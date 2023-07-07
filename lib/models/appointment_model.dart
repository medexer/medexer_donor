class AppointmentModel {
  int? pkid;
  String? id;
  String? appointmentID;
  String? date;
  int? donor;
  String? message;
  int? hospital;
  String? donationDate;
  bool? isDonated;
  bool? isForAdult;
  bool? getNotifiedOnBloodUse;
  HospitalInfo? hospitalInfo;
  HospitalProfile? hospitalProfile;
  CenterGeoLocation? centerGeoLocation;
  String? createdAt;

  AppointmentModel(
      {this.pkid,
      this.id,
      this.appointmentID,
      this.date,
      this.donor,
      this.message,
      this.hospital,
      this.donationDate,
      this.isDonated,
      this.isForAdult,
      this.getNotifiedOnBloodUse,
      this.hospitalInfo,
      this.hospitalProfile,
      this.centerGeoLocation,
      this.createdAt});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    pkid = json['pkid'];
    id = json['id'];
    appointmentID = json['appointmentID'];
    date = json['date'];
    donor = json['donor'];
    message = json['message'];
    hospital = json['hospital'];
    donationDate = json['donationDate'];
    isDonated = json['isDonated'];
    isForAdult = json['isForAdult'];
    getNotifiedOnBloodUse = json['getNotifiedOnBloodUse'];
    hospitalInfo = json['hospitalInfo'] != null
        ? new HospitalInfo.fromJson(json['hospitalInfo'])
        : null;
    hospitalProfile = json['hospitalProfile'] != null
        ? new HospitalProfile.fromJson(json['hospitalProfile'])
        : null;
    centerGeoLocation = json['centerGeoLocation'] != null
        ? new CenterGeoLocation.fromJson(json['centerGeoLocation'])
        : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkid'] = this.pkid;
    data['id'] = this.id;
    data['appointmentID'] = this.appointmentID;
    data['date'] = this.date;
    data['donor'] = this.donor;
    data['message'] = this.message;
    data['hospital'] = this.hospital;
    data['donationDate'] = this.donationDate;
    data['isDonated'] = this.isDonated;
    data['isForAdult'] = this.isForAdult;
    data['getNotifiedOnBloodUse'] = this.getNotifiedOnBloodUse;
    if (this.hospitalInfo != null) {
      data['hospitalInfo'] = this.hospitalInfo!.toJson();
    }
    if (this.hospitalProfile != null) {
      data['hospitalProfile'] = this.hospitalProfile!.toJson();
    }
    if (this.centerGeoLocation != null) {
      data['centerGeoLocation'] = this.centerGeoLocation!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class HospitalInfo {
  int? pkid;
  String? hospitalName;
  String? location;
  String? email;

  HospitalInfo({this.pkid, this.hospitalName, this.location, this.email});

  HospitalInfo.fromJson(Map<String, dynamic> json) {
    pkid = json['pkid'];
    hospitalName = json['hospitalName'];
    location = json['location'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkid'] = this.pkid;
    data['hospitalName'] = this.hospitalName;
    data['location'] = this.location;
    data['email'] = this.email;
    return data;
  }
}

class HospitalProfile {
  String? address;
  String? state;
  String? hospitalLogo;
  String? aboutHospital;
  String? cityProvince;
  String? contactNumber;
  String? hospitalImage;

  HospitalProfile(
      {this.address,
      this.state,
      this.hospitalLogo,
      this.aboutHospital,
      this.cityProvince,
      this.contactNumber,
      this.hospitalImage});

  HospitalProfile.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    state = json['state'];
    hospitalLogo = json['hospitalLogo'];
    aboutHospital = json['about_hospital'];
    cityProvince = json['city_province'];
    contactNumber = json['contact_number'];
    hospitalImage = json['hospitalImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['state'] = this.state;
    data['hospitalLogo'] = this.hospitalLogo;
    data['about_hospital'] = this.aboutHospital;
    data['city_province'] = this.cityProvince;
    data['contact_number'] = this.contactNumber;
    data['hospitalImage'] = this.hospitalImage;
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
