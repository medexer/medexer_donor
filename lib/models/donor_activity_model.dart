class HospitalScreenModel {
  List<DonorActivityModel>? donorActivityModel;

  HospitalScreenModel({this.donorActivityModel});

  HospitalScreenModel.fromJson(Map<String, dynamic> json) {
    if (json['donorActivityModel'] != null) {
      donorActivityModel = <DonorActivityModel>[];
      json['donorActivityModel'].forEach((v) {
        donorActivityModel!.add(new DonorActivityModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.donorActivityModel != null) {
      data['donorActivityModel'] = this.donorActivityModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class DonorActivityModel {
  String? id;
  int? pkid;
  String? message;
  String? hospital;
  String? donorID;

  //static var donorActivityLoading = false;
  DonorActivityModel(
      {this.id,
      this.pkid,
      this.message,
      this.donorID,
      this.hospital,
      });

  DonorActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pkid = json['pkid'];
    message = json['message'];
    donorID = json['donorID'];
    hospital = json['hospital'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pkid'] = this.pkid;
    data['message'] = this.message;
    data['donorID'] = this.donorID;
    data['hospital'] = this.hospital;
    return data;
  }
}
