class KYCFormDataModel {
  String? bloodGroup;
  String? genotype;
  bool? haveDonatedBlood;
  String? lastBloodDonationTime;
  bool? hasTattos;
  bool? tobaccoUsage;
  bool? isRecentVaccineRecipient;

  KYCFormDataModel(
      {this.bloodGroup,
      this.genotype,
      this.haveDonatedBlood,
      this.lastBloodDonationTime,
      this.tobaccoUsage,
      this.isRecentVaccineRecipient,
      this.hasTattos});

  KYCFormDataModel.fromJson(Map<String, dynamic> json) {
    bloodGroup = json['bloodGroup'];
    genotype = json['genotype'];
    haveDonatedBlood = json['haveDonatedBlood'];
    lastBloodDonationTime = json['lastBloodDonationTime'];
    hasTattos = json['hasTattos'];
    tobaccoUsage = json['tobaccoUsage'];
    isRecentVaccineRecipient = json['isRecentVaccineRecipient'];
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
    return data;
  }
}
