class BankHotModel {
  String code;
  String result;
  String message;
  int errno;
  List<BankHotData> data;

  BankHotModel({this.code, this.result, this.message, this.errno, this.data});

  BankHotModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    result = json['result'];
    message = json['message'];
    errno = json['errno'];
    if (json['data'] != null) {
      data = new List<BankHotData>();
      json['data'].forEach((v) {
        data.add(new BankHotData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['result'] = this.result;
    data['message'] = this.message;
    data['errno'] = this.errno;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankHotData {
  int id;
  String name;
  String img;
  String addtime;
  String welfare;
  String speed;
  double banklimit;
  String passrate;
  String shorturl;

  BankHotData(
      {this.id,
        this.name,
        this.img,
        this.addtime,
        this.welfare,
        this.speed,
        this.banklimit,
        this.passrate,
        this.shorturl});

  BankHotData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    addtime = json['addtime'];
    welfare = json['welfare'];
    speed = json['speed'];
    banklimit = json['banklimit'];
    passrate = json['passrate'];
    shorturl = json['shorturl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['addtime'] = this.addtime;
    data['welfare'] = this.welfare;
    data['speed'] = this.speed;
    data['banklimit'] = this.banklimit;
    data['passrate'] = this.passrate;
    data['shorturl'] = this.shorturl;
    return data;
  }
}

