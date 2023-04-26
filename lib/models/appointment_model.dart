class AppointmentModel {
  int? pkid;
  String? id;
  String? date;
  int? donor;
  String? message;
  int? hospital;
  bool? isDonated;
  HospitalInfo? hospitalInfo;
  String? createdAt;

  AppointmentModel(
      {this.pkid,
      this.id,
      this.date,
      this.donor,
      this.message,
      this.hospital,
      this.isDonated,
      this.hospitalInfo,
      this.createdAt});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    pkid = json['pkid'];
    id = json['id'];
    date = json['date'];
    donor = json['donor'];
    message = json['message'];
    hospital = json['hospital'];
    isDonated = json['isDonated'];
    hospitalInfo = json['hospitalInfo'] != null
        ? new HospitalInfo.fromJson(json['hospitalInfo'])
        : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkid'] = this.pkid;
    data['id'] = this.id;
    data['date'] = this.date;
    data['donor'] = this.donor;
    data['message'] = this.message;
    data['hospital'] = this.hospital;
    data['isDonated'] = this.isDonated;
    if (this.hospitalInfo != null) {
      data['hospitalInfo'] = this.hospitalInfo!.toJson();
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
