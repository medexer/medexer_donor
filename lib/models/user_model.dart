class UserModel {
  String? id;
  int? pkid;
  String? fullName;
  String? email;
  String? donorID;
  bool? isActive;
  String? avatar;
  bool? isDonor;
  String? otp;
  bool? isKycUpdated;

  UserModel(
      {this.id,
      this.pkid,
      this.fullName,
      this.email,
      this.donorID,
      this.isActive,
      this.avatar,
      this.isDonor,
      this.otp,
      this.isKycUpdated});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pkid = json['pkid'];
    fullName = json['fullName'];
    email = json['email'];
    donorID = json['donorID'];
    isActive = json['is_active'];
    avatar = json['avatar'];
    isDonor = json['is_donor'];
    otp = json['otp'];
    isKycUpdated = json['is_kyc_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pkid'] = this.pkid;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['donorID'] = this.donorID;
    data['is_active'] = this.isActive;
    data['avatar'] = this.avatar;
    data['is_donor'] = this.isDonor;
    data['otp'] = this.otp;
    data['is_kyc_updated'] = this.isKycUpdated;
    return data;
  }
}
