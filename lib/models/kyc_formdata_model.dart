import 'package:file_picker/file_picker.dart';

class KYCFormDataModel {
  String? bloodGroup;
  String? genotype;
  bool? haveDonatedBlood;
  String? lastBloodDonationTime;
  bool? hasTattos;
  bool? tobaccoUsage;
  bool? isRecentVaccineRecipient;
  late PlatformFile? documentRear;
  late PlatformFile? documentCover;
  bool? isDocumentRearUploaded;
  bool? isDocumentCoverUploaded;
  String? identificationType;

  KYCFormDataModel({
    this.bloodGroup,
    this.genotype,
    this.haveDonatedBlood,
    this.lastBloodDonationTime,
    this.tobaccoUsage,
    this.isRecentVaccineRecipient,
    this.hasTattos,
    this.documentCover,
    this.documentRear,
    this.isDocumentCoverUploaded,
    this.isDocumentRearUploaded,
    this.identificationType,
  });

  KYCFormDataModel.fromJson(Map<String, dynamic> json) {
    bloodGroup = json['bloodGroup'];
    genotype = json['genotype'];
    haveDonatedBlood = json['haveDonatedBlood'];
    lastBloodDonationTime = json['lastBloodDonationTime'];
    hasTattos = json['hasTattos'];
    tobaccoUsage = json['tobaccoUsage'];
    isRecentVaccineRecipient = json['isRecentVaccineRecipient'];

    documentCover = json['documentCover'];
    documentRear = json['documentRear'];
    isDocumentCoverUploaded = json['isDocumentCoverUploaded'];
    isDocumentRearUploaded = json['isDocumentRearUploaded'];
    identificationType = json['identificationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bloodGroup'] = this.bloodGroup;
    data['genotype'] = this.genotype;
    data['haveDonatedBlood'] = this.haveDonatedBlood;
    data['lastBloodDonationTime'] = this.lastBloodDonationTime;
    data['hasTattos'] = this.hasTattos;
    data['tobaccoUsage'] = this.tobaccoUsage;
    data['isRecentVaccineRecipient'] = this.isRecentVaccineRecipient;

    documentCover = this.documentCover;
    documentRear = this.documentRear;
    isDocumentCoverUploaded = this.isDocumentCoverUploaded;
    isDocumentRearUploaded = this.isDocumentRearUploaded;
    identificationType = this.identificationType;
    return data;
  }
}
