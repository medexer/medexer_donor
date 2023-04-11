// ignore_for_file: prefer_collection_literals

class UserModel {
  String? id;
  int? pkid;
  String? fullName;
  //String? lastName;
  String? email;
  // String? phone;
  // String? avatar;
  // String? country;
  // bool? isActive;
  // bool? isVerified;
  // String? accountActivationOtp;
  // String? resetPasswordOtp;

  UserModel(
      {this.id,
      this.pkid,
      this.fullName,
      //this.lastName,
      this.email,
      // this.phone,
      // this.avatar,
      // this.country,
      // this.isActive,
      // this.isVerified,
      // this.accountActivationOtp,
      //this.resetPasswordOtp
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pkid = json['pkid'];
    fullName = json['fullName'];
    //lastName = json['last_name'];
    email = json['email'];
    // phone = json['phone'];
    // avatar = json['avatar'];
    // country = json['country'];
    // isActive = json['is_active'];
    // isVerified = json['is_verified'];
    // accountActivationOtp = json['account_activation_otp'];
    // resetPasswordOtp = json['reset_password_otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =Map<String, dynamic>();
    data['id'] = id;
    data['pkid'] = pkid;
    data['fullName'] = fullName;
    //data['last_name'] = lastName;
    data['email'] = email;
    // data['phone'] = phone;
    // data['avatar'] = avatar;
    // data['country'] = country;
    // data['is_active'] = isActive;
    // data['is_verified'] = isVerified;
    // data['account_activation_otp'] = accountActivationOtp;
    // data['reset_password_otp'] = resetPasswordOtp;
    return data;
  }
}

