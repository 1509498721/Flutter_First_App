class GetServiceModel {
  String code;
  String result;
  String message;
  int errno;
  String data;

  GetServiceModel({this.code, this.result, this.message, this.errno, this.data});

  GetServiceModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    result = json['result'];
    message = json['message'];
    errno = json['errno'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['result'] = this.result;
    data['message'] = this.message;
    data['errno'] = this.errno;
    data['data'] = this.data;
    return data;
  }
}

