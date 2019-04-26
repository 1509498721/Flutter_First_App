class VersionModel {
  String code;
  String msg;
  int time;
  List<Items> items;

  VersionModel({this.code, this.msg, this.time, this.items});

  VersionModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    time = json['time'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['time'] = this.time;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int id;
  int type;
  String createTime;
  int updateTime;
  int appId;
  String versionId;
  int versionCode;
  String apkUrl;
  String upgradePrompt;

  Items(
      {this.id,
        this.type,
        this.createTime,
        this.updateTime,
        this.appId,
        this.versionId,
        this.versionCode,
        this.apkUrl,
        this.upgradePrompt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    appId = json['appId'];
    versionId = json['versionId'];
    versionCode = json['versionCode'];
    apkUrl = json['apkUrl'];
    upgradePrompt = json['upgradePrompt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['appId'] = this.appId;
    data['versionId'] = this.versionId;
    data['versionCode'] = this.versionCode;
    data['apkUrl'] = this.apkUrl;
    data['upgradePrompt'] = this.upgradePrompt;
    return data;
  }
}

