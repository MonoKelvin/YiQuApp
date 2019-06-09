class UserJson {
  String uuid;
  String userName;
  String password;
  String address;
  String headImage;
  String gender;
  String signiture;

  UserJson(
      {this.uuid,
      this.userName,
      this.password,
      this.address,
      this.headImage,
      this.gender,
      this.signiture});

  UserJson.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userName = json['userName'];
    password = json['password'];
    address = json['address'];
    headImage = json['headImage'];
    gender = json['gender'];
    signiture = json['signiture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['address'] = this.address;
    data['headImage'] = this.headImage;
    data['gender'] = this.gender;
    data['signiture'] = this.signiture;
    return data;
  }
}
