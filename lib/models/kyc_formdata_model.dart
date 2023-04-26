class KYCFormDataModel {
  String? bloodGroup;
  String? genotype;
  bool? haveDonatedBlood;
  String? lastBloodDonationTime;
  bool? hasTattos;

  KYCFormDataModel(
      {this.bloodGroup,
      this.genotype,
      this.haveDonatedBlood,
      this.lastBloodDonationTime,
      this.hasTattos});

  KYCFormDataModel.fromJson(Map<String, dynamic> json) {
    bloodGroup = json['bloodGroup'];
    genotype = json['genotype'];
    haveDonatedBlood = json['haveDonatedBlood'];
    lastBloodDonationTime = json['lastBloodDonationTime'];
    hasTattos = json['hasTattos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bloodGroup'] = this.bloodGroup;
    data['genotype'] = this.genotype;
    data['haveDonatedBlood'] = this.haveDonatedBlood;
    data['lastBloodDonationTime'] = this.lastBloodDonationTime;
    data['hasTattos'] = this.hasTattos;
    return data;
  }
}
