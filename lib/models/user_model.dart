class UserModel {
  String? id;
  int? pkid;
  String? fullName;
  String? email;
  String? donorID;
  bool? isActive;
  bool? isDonor;
  String? otp;

  UserModel(
      {this.id,
      this.pkid,
      this.fullName,
      this.email,
      this.donorID,
      this.isActive,
      this.isDonor,
      this.otp});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pkid = json['pkid'];
    fullName = json['fullName'];
    email = json['email'];
    donorID = json['donorID'];
    isActive = json['is_active'];
    isDonor = json['is_donor'];
    otp = json['otp'];
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
    return data;
  }
}
