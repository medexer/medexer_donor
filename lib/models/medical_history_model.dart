class MedicalHistoryModel {
  String? id;
  int? pkid;
  String? hiv;
  String? hepatitisB;
  String? hepatitisC;
  String? vdrl;
  String? bloodPressure;
  String? bodyTemperature;
  String? bloodGroup;
  String? genotype;
  String? pcv;
  String? weight;
  String? height;
  int? donor;
  HospitalProfile? hospitalProfile;
  int? appointment;
  AppointmentInfo? appointmentInfo;
  int? author;
  String? createdAt;
  MedicalHistoryModel(
      {this.id,
      this.pkid,
      this.hiv,
      this.hepatitisB,
      this.hepatitisC,
      this.vdrl,
      this.bloodPressure,
      this.bodyTemperature,
      this.bloodGroup,
      this.genotype,
      this.pcv,
      this.weight,
      this.height,
      this.donor,
      this.hospitalProfile,
      this.appointment,
      this.appointmentInfo,
      this.author,
      this.createdAt});
  MedicalHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pkid = json['pkid'];
    hiv = json['hiv'];
    hepatitisB = json['hepatitisB'];
    hepatitisC = json['hepatitisC'];
    vdrl = json['vdrl'];
    bloodPressure = json['bloodPressure'];
    bodyTemperature = json['bodyTemperature'];
    bloodGroup = json['bloodGroup'];
    genotype = json['genotype'];
    pcv = json['pcv'];
    weight = json['weight'];
    height = json['height'];
    donor = json['donor'];
    hospitalProfile = json['hospitalProfile'] != null
        ? new HospitalProfile.fromJson(json['hospitalProfile'])
        : null;
    appointment = json['appointment'];
    appointmentInfo = json['appointmentInfo'] != null
        ? new AppointmentInfo.fromJson(json['appointmentInfo'])
        : null;
    author = json['author'];
    createdAt = json['created_at'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pkid'] = this.pkid;
    data['hiv'] = this.hiv;
    data['hepatitisB'] = this.hepatitisB;
    data['hepatitisC'] = this.hepatitisC;
    data['vdrl'] = this.vdrl;
    data['bloodPressure'] = this.bloodPressure;
    data['bodyTemperature'] = this.bodyTemperature;
    data['bloodGroup'] = this.bloodGroup;
    data['genotype'] = this.genotype;
    data['pcv'] = this.pcv;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['donor'] = this.donor;
    if (this.hospitalProfile != null) {
      data['hospitalProfile'] = this.hospitalProfile!.toJson();
    }
    data['appointment'] = this.appointment;
    if (this.appointmentInfo != null) {
      data['appointmentInfo'] = this.appointmentInfo!.toJson();
    }
    data['author'] = this.author;
    data['created_at'] = this.createdAt;
    return data;
  }
}
class HospitalProfile {
  String? email;
  String? hospitalName;
  HospitalProfile({this.email, this.hospitalName});
  HospitalProfile.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    hospitalName = json['hospitalName'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['hospitalName'] = this.hospitalName;
    return data;
  }
}
class AppointmentInfo {
  String? donationDate;
  String? appointmentID;
  AppointmentInfo({this.donationDate, this.appointmentID});
  AppointmentInfo.fromJson(Map<String, dynamic> json) {
    donationDate = json['donationDate'];
    appointmentID = json['appointmentID'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['donationDate'] = this.donationDate;
    data['appointmentID'] = this.appointmentID;
    return data;
  }
}