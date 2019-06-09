class IdleJson {
  String uuid;
  List<String> images;
  String title;
  String description;
  String timeOfTheDay;
  String category;
  String user;
  int idleType;
  int price;
  int satisfiedCount;

  IdleJson(
      {this.uuid,
      this.images,
      this.title,
      this.description,
      this.timeOfTheDay,
      this.category,
      this.user,
      this.idleType,
      this.price,
      this.satisfiedCount});

  IdleJson.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    images = json['images'].cast<String>();
    title = json['title'];
    description = json['description'];
    timeOfTheDay = json['timeOfTheDay'];
    category = json['category'];
    user = json['user'];
    idleType = json['idleType'];
    price = json['price'];
    satisfiedCount = json['satisfiedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['images'] = this.images;
    data['title'] = this.title;
    data['description'] = this.description;
    data['timeOfTheDay'] = this.timeOfTheDay;
    data['category'] = this.category;
    data['user'] = this.user;
    data['idleType'] = this.idleType;
    data['price'] = this.price;
    data['satisfiedCount'] = this.satisfiedCount;
    return data;
  }
}
