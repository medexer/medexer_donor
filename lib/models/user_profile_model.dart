class UserProfileModel {
  String? id;
  int? pkid;
  String? nationality;
  String? gender;
  String? religion;
  String? address;
  String? state;
  String? cityProvince;
  String? contactNumber;
  String? userAvatar;
  bool? isProfileUpdated;

  UserProfileModel(
      {this.id,
      this.pkid,
      this.nationality,
      this.gender,
      this.religion,
      this.address,
      this.state,
      this.cityProvince,
      this.contactNumber,
      this.userAvatar,
      this.isProfileUpdated});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pkid = json['pkid'];
    nationality = json['nationality'];
    gender = json['gender'];
    religion = json['religion'];
    address = json['address'];
    state = json['state'];
    cityProvince = json['city_province'];
    contactNumber = json['contact_number'];
    userAvatar = json['userAvatar'];
    isProfileUpdated = json['is_profile_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pkid'] = this.pkid;
    data['nationality'] = this.nationality;
    data['gender'] = this.gender;
    data['religion'] = this.religion;
    data['address'] = this.address;
    data['state'] = this.state;
    data['city_province'] = this.cityProvince;
    data['contact_number'] = this.contactNumber;
    data['userAvatar'] = this.userAvatar;
    data['is_profile_updated'] = this.isProfileUpdated;
    return data;
  }
}
