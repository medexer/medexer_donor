
class DonorActivityModel {
  String? id;
  int? pkid;
  String? donor;
  String? message;
  String? hospital;
  String? email;
  String? donorID;
  DateTime? date = DateTime.now();
 
  

  DonorActivityModel(
      {this.id,
      this.pkid,
      this.message,
      this.email,
      this.donorID,
      this.hospital,
      this.date,
      this.donor
      });

  DonorActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pkid = json['pkid'];
    message = json['message'];
    email = json['email'];
    donorID = json['donorID'];
    hospital = json['hospital'];
    date = json['date'];
    donor = json['donor'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pkid'] = this.pkid;
    data['message'] = this.message;
    data['email'] = this.email;
    data['donorID'] = this.donorID;
    data['hospital'] = this.hospital;
    data['date'] = this.date;
    data['donor'] = this.donor;
    return data;
  }
}
