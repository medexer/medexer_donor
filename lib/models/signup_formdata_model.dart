class SignupFormDataModel {
  String? fullName;
  String? email;
  String? password;
  // String? nationality;
  // String? gender;
  // String? religion;
  // String? address;
  // String? state;
  // String? contactNumber;
  // String? cityProvince;

  SignupFormDataModel(
      {this.fullName,
      this.email,
      this.password,
      // this.nationality,
      // this.gender,
      // this.religion,
      // this.address,
      // this.state,
      // this.contactNumber,
      // this.cityProvince
    });

  SignupFormDataModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    // nationality = json['nationality'];
    // gender = json['gender'];
    // religion = json['religion'];
    // address = json['address'];
    // state = json['state'];
    // contactNumber = json['contact_number'];
    // cityProvince = json['city_province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    // data['nationality'] = this.nationality;
    // data['gender'] = this.gender;
    // data['religion'] = this.religion;
    // data['address'] = this.address;
    // data['state'] = this.state;
    // data['contact_number'] = this.contactNumber;
    // data['city_province'] = this.cityProvince;
    return data;
  }
}
