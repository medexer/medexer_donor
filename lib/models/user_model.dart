
class UserModel {
  String? id;
  int? pkid;
  String? fullName;
  String? email;
  String? donorID;
  bool? isActive;
  String? isDonor;
  String? otp;
  String? bloodGroup;
  String? genotype;
  String? haveDonatedBlood;
  String? lastBloodDonationTime;
  String? hasTattos; 
  String? documentUploadCover;
  String? identificationType;
  String? documentUploadRear;
  

  UserModel(
      {this.id,
      this.pkid,
      this.fullName,
      this.email,
      this.donorID,
      this.isActive,
      this.isDonor,
      this.otp,
      this.bloodGroup,
      this.genotype,
      this.haveDonatedBlood,
      this.lastBloodDonationTime,
      this.hasTattos,
      this.documentUploadCover
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pkid = json['pkid'];
    fullName = json['fullName'];
    email = json['email'];
    donorID = json['donorID'];
    isActive = json['is_active'];
    isDonor = json['is_donor'];
    otp = json['otp'];
    bloodGroup = json['bloodGroup'];
    genotype = json['genotype'];
    haveDonatedBlood = json['haveDonatedBlood'];
    lastBloodDonationTime = json['lastBloodDonationTime'];
    hasTattos = json['hasTattos'];
    documentUploadCover=json['documentUploadCover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pkid'] = this.pkid;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['donorID'] = this.donorID;
    data['is_active'] = this.isActive;
    data['is_donor'] = this.isDonor;
    data['otp'] = this.otp;
    data['blood_group'] = this.bloodGroup;
    data['genotype'] = this.genotype;
    data['haveDonatedBlood'] = this.haveDonatedBlood;
    data['lastBloodDonationTime'] = this.lastBloodDonationTime;
    data['hasTattos'] = this.hasTattos;
    data['documentUploadCover'] =this.documentUploadCover;
    return data;
  }
}
