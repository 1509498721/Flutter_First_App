class SSMModel {
  String code;
  String msg;
  int time;
  Null items;

  SSMModel({this.code, this.msg, this.time, this.items});

  SSMModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    time = json['time'];
    items = json['items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['time'] = this.time;
    data['items'] = this.items;
    return data;
  }
}

