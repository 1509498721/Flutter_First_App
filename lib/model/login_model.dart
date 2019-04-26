class LoginModel {
  String code;
  String msg;
  int time;
  List<LoginItemsModel> items;
  String token;

  LoginModel({this.code, this.msg, this.time, this.items, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    time = json['time'];
    if (json['items'] != null) {
      items = new List<LoginItemsModel>();
      json['items'].forEach((v) {
        items.add(new LoginItemsModel.fromJson(v));
      });
    }
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['time'] = this.time;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['token'] = this.token;
    return data;
  }
}

class LoginItemsModel {
  int id;
  String title;
  String phone;
  String pwd;
  int level;
  String img;
  String addTime;
  String loginTime;
  String loginIp;
  String registeredSource;
  int adminId;
  int authenticationStatus;
  String enterpriseName;
  int idNumber;
  String email;
  String businessLicense;
  String authenticationMessage;
  String frendSource;

  LoginItemsModel(
      {this.id,
      this.title,
      this.phone,
      this.pwd,
      this.level,
      this.img,
      this.addTime,
      this.loginTime,
      this.loginIp,
      this.registeredSource,
      this.adminId,
      this.authenticationStatus,
      this.enterpriseName,
      this.idNumber,
      this.email,
      this.businessLicense,
      this.authenticationMessage,
      this.frendSource});

  LoginItemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    phone = json['phone'];
    pwd = json['pwd'];
    level = json['level'];
    img = json['img'];
    addTime = json['addTime'];
    loginTime = json['loginTime'];
    loginIp = json['loginIp'];
    registeredSource = json['registeredSource'];
    adminId = json['adminId'];
    authenticationStatus = json['authenticationStatus'];
    enterpriseName = json['enterpriseName'];
    idNumber = json['idNumber'];
    email = json['email'];
    businessLicense = json['businessLicense'];
    frendSource=json['frendSource'];
    authenticationMessage = json['authenticationMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['phone'] = this.phone;
    data['pwd'] = this.pwd;
    data['level'] = this.level;
    data['img'] = this.img;
    data['addTime'] = this.addTime;
    data['loginTime'] = this.loginTime;
    data['loginIp'] = this.loginIp;
    data['registeredSource'] = this.registeredSource;
    data['adminId'] = this.adminId;
    data['authenticationStatus'] = this.authenticationStatus;
    data['enterpriseName'] = this.enterpriseName;
    data['idNumber'] = this.idNumber;
    data['email'] = this.email;
    data['businessLicense'] = this.businessLicense;
    data['authenticationMessage'] = this.authenticationMessage;
    return data;
  }
}
