class DonationCenterGeoDataModel {
  String? centerName;
  String? email;
  String? address;
  String? hospitalImage;
  Location? location;

  DonationCenterGeoDataModel(
      {this.centerName, this.email, this.address, this.location});

  DonationCenterGeoDataModel.fromJson(Map<String, dynamic> json) {
    centerName = json['centerName'];
    email = json['email'];
    address = json['address'];
    hospitalImage = json['hospitalImage'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['centerName'] = this.centerName;
    data['email'] = this.email;
    data['address'] = this.address;
    data['hospitalImage'] = this.hospitalImage;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
