class VersionModel {
  String createTime;
  String updateTime;
  String apkUrl;
  int appId;
  int id;
  int type;
  String upgradePrompt;
  String versionCode;
  String versionId;

  VersionModel(
      {this.createTime,
        this.updateTime,
        this.apkUrl,
        this.appId,
        this.id,
        this.type,
        this.upgradePrompt,
        this.versionCode,
        this.versionId});

  VersionModel.fromJson(Map<String, dynamic> json) {
    createTime = json['CreateTime'];
    updateTime = json['UpdateTime'];
    apkUrl = json['apkUrl'];
    appId = json['appId'];
    createTime = json['createTime'];
    id = json['id'];
    type = json['type'];
    updateTime = json['updateTime'];
    upgradePrompt = json['upgradePrompt'];
    versionCode = json['versionCode'];
    versionId = json['versionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CreateTime'] = this.createTime;
    data['UpdateTime'] = this.updateTime;
    data['apkUrl'] = this.apkUrl;
    data['appId'] = this.appId;
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['type'] = this.type;
    data['updateTime'] = this.updateTime;
    data['upgradePrompt'] = this.upgradePrompt;
    data['versionCode'] = this.versionCode;
    data['versionId'] = this.versionId;
    return data;
  }
}

