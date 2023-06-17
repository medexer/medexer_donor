class MapModel {
  String? id;
  int? pkid;
  String? hospitalName;
  String? email;
  String? hospitalID;
  String? location;
  bool? isActive;

  //dummies
  double? lat;
  double? long;

  MapModel(
      {this.id,
      this.pkid,
      this.hospitalName,
      this.email,
      this.hospitalID,
      this.location,
      this.isActive,
      //dummies
      this.lat,
      this.long,
      });

  MapModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pkid = json['pkid'];
    hospitalName = json['hospitalName'];
    email = json['email'];
    hospitalID = json['hospitalID'];
    location = json['location'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pkid'] = this.pkid;
    data['hospitalName'] = this.hospitalName;
    data['email'] = this.email;
    data['hospitalID'] = this.hospitalID;
    data['location'] = this.location;
    data['is_active'] = this.isActive;
    return data;
  }
}

// ignore: non_constant_identifier_names
List<MapModel>MapModels=[
    MapModel(
      pkid: 1,
      hospitalName: 'Plateau State hospital',
      lat: 9.895836673, 
      long: 8.88430300725 
    ),
    MapModel(
      pkid: 2,
      hospitalName: 'JUTH',
      lat: 9.895725562, 
      long: 8.88430300725 
    ),
    MapModel(
      pkid: 3,
      hospitalName: 'ECWA Hospital',
      lat: 9.895614562, 
      long: 8.88430300725 
    )

  ];


