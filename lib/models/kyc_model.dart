import 'dart:html';

class KycModel {
  String? id;
  int? pkid;
  String? bloodGroup;
  String? genotype;
  String? haveDonatedBlood;
  String? lastBloodDonationTime;
  String? hasTattos;
  String? identificationType;
  File? documentUploadCover;
  File? documentUploadRear;
  String? donorID;
  bool? isActive;
  bool? isDonor;
  String? otp;
  bool? isKycUpdated;

  KycModel(
      {this.id,
      this.pkid,
      this.bloodGroup,
      this.genotype,
      this.haveDonatedBlood,
      this.lastBloodDonationTime,
      this.hasTattos,
      this.identificationType,
      this.documentUploadCover,
      this.documentUploadRear,
      this.donorID,
      this.isActive,
      this.isDonor,
      this.otp,
      this.isKycUpdated});

  KycModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pkid = json['pkid'];
    bloodGroup = json['bloodGroup'];
    genotype = json['genotype'];
    donorID = json['donorID'];
    haveDonatedBlood= json['haveDonatedBlood'];
    lastBloodDonationTime=json['lastBloodDonationTime'];
    hasTattos=json['hasTattos'];
    identificationType=json['identificationType'];
    documentUploadCover=json['documentUploadCover'];
    documentUploadRear=json['documentUploadRear'];
    isActive = json['is_active'];
    isDonor = json['is_donor'];
    otp = json['otp'];
    isKycUpdated = json['is_kyc_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pkid'] = this.pkid;
    data['bloodGroup'] = this.bloodGroup;
    data['genotype'] = this.genotype;
    data['haveDonatedBlood']=this.haveDonatedBlood;
    data['lastBloodDonationTime']=this.lastBloodDonationTime;
    data['hasTattos']=this.hasTattos;
    data['identificationType']=this.identificationType;
    data['documentUploadCover']=this.documentUploadCover;
    data['documentUploadRear']=this.documentUploadRear
    data['donorID'] = this.donorID;
    data['is_active'] = this.isActive;
    data['is_donor'] = this.isDonor;
    data['otp'] = this.otp;
    data['is_kyc_updated'] = this.isKycUpdated;
    return data;
  }
}
