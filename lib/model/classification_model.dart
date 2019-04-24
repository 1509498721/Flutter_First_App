class ClassificationModel {
  List<ClassificationPropertyModel> property;

  ClassificationModel({this.property});

  ClassificationModel.fromJson(Map<String, dynamic> json) {
    if (json['property'] != null) {
      property = new List<ClassificationPropertyModel>();
      json['property'].forEach((v) {
        property.add(new ClassificationPropertyModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.property != null) {
      data['property'] = this.property.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassificationPropertyModel {
  int id;
  String title;
  String img;
  int level;
  String addTime;

  ClassificationPropertyModel({this.id, this.title, this.img, this.level, this.addTime});

  ClassificationPropertyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    img = json['img'];
    level = json['level'];
    addTime = json['addTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['img'] = this.img;
    data['level'] = this.level;
    data['addTime'] = this.addTime;
    return data;
  }
}