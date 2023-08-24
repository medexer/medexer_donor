import 'package:file_picker/file_picker.dart';

class KYCPersonalDataModel {
  String? bloodGroup;
  String? genotype;
  String? haveDonatedBlood;
  String? lastBloodDonationTime;
  String? hasTattos;
  String? tobaccoUsage;
  String? isRecentVaccineRecipient;
  String? previouslyDonatedBlood;
  String? previouslyDonatedBloodTimeline;
  late PlatformFile? documentRear;
  late PlatformFile? documentCover;
  bool? isDocumentRearUploaded;
  bool? isDocumentCoverUploaded;
  String? identificationType;

  KYCPersonalDataModel({
    this.bloodGroup,
    this.genotype,
    this.haveDonatedBlood,
    this.lastBloodDonationTime,
    this.tobaccoUsage,
    this.isRecentVaccineRecipient,
    this.previouslyDonatedBlood,
    this.previouslyDonatedBloodTimeline,
    this.hasTattos,
    this.documentCover,
    this.documentRear,
    this.isDocumentCoverUploaded,
    this.isDocumentRearUploaded,
    this.identificationType,
  });

  KYCPersonalDataModel.fromJson(Map<String, dynamic> json) {
    bloodGroup = json['bloodGroup'];
    genotype = json['genotype'];
    haveDonatedBlood = json['haveDonatedBlood'];
    lastBloodDonationTime = json['lastBloodDonationTime'];
    hasTattos = json['hasTattos'];
    tobaccoUsage = json['tobaccoUsage'];
    isRecentVaccineRecipient = json['isRecentVaccineRecipient'];
    previouslyDonatedBlood = json['previouslyDonatedBlood'];
    previouslyDonatedBloodTimeline = json['previouslyDonatedBloodTimeline'];

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
    data['previouslyDonatedBlood'] = this.previouslyDonatedBlood;
    data['previouslyDonatedBloodTimeline'] =
        this.previouslyDonatedBloodTimeline;

    documentCover = this.documentCover;
    documentRear = this.documentRear;
    isDocumentCoverUploaded = this.isDocumentCoverUploaded;
    isDocumentRearUploaded = this.isDocumentRearUploaded;
    identificationType = this.identificationType;
    return data;
  }
}
