class AdvertisingModel {
  List<AdvertisingGoodsModel> goods;

  AdvertisingModel({this.goods});

  AdvertisingModel.fromJson(Map<String, dynamic> json) {
    if (json['goods'] != null) {
      goods = new List<AdvertisingGoodsModel>();
      json['goods'].forEach((v) {
        goods.add(new AdvertisingGoodsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.goods != null) {
      data['goods'] = this.goods.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdvertisingGoodsModel {
  int id;
  String title;
  int categoryId;
  String propertyIds;
  int tagId;
  String img;
  String applicationrequirement;
  String details;
  int level;
  String info;
  String url;
  String loogLine;
  int appoint;
  int status;
  String addTime;
  int activation;
  int homepicture;
  int statusCode;
  String cpa;
  int pv;
  int uv;
  String uvEarnings;
  String cpaPrice;
  int adminId;
  int click;
  int detailsId;
  int auditfailed;
  int applyCount;
  String shortUrl;
  String deadline;
  String paceLending;
  String successRate;
  String reviewWay;
  String accountWay;
  String creditrequired;
  String platformname;
  String interestrate;
  String limit;
  String goodsSource;

  AdvertisingGoodsModel(
      {this.id,
      this.title,
      this.categoryId,
      this.propertyIds,
      this.tagId,
      this.img,
      this.applicationrequirement,
      this.details,
      this.level,
      this.info,
      this.url,
      this.loogLine,
      this.appoint,
      this.status,
      this.addTime,
      this.activation,
      this.homepicture,
      this.statusCode,
      this.cpa,
      this.pv,
      this.uv,
      this.uvEarnings,
      this.cpaPrice,
      this.adminId,
      this.click,
      this.detailsId,
      this.auditfailed,
      this.applyCount,
      this.shortUrl,
      this.deadline,
      this.paceLending,
      this.successRate,
      this.reviewWay,
      this.accountWay,
      this.creditrequired,
      this.platformname,
      this.interestrate,
      this.limit,
      this.goodsSource});

  AdvertisingGoodsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['categoryId'];
    propertyIds = json['propertyIds'];
    tagId = json['tagId'];
    img = json['img'];
    applicationrequirement = json['applicationrequirement'];
    details = json['details'];
    level = json['level'];
    info = json['info'];
    url = json['url'];
    loogLine = json['loogLine'];
    appoint = json['appoint'];
    status = json['status'];
    addTime = json['addTime'];
    activation = json['activation'];
    homepicture = json['homepicture'];
    statusCode = json['statusCode'];
    cpa = json['cpa'];
    pv = json['pv'];
    uv = json['uv'];
    uvEarnings = json['uvEarnings'];
    cpaPrice = json['cpaPrice'];
    adminId = json['adminId'];
    click = json['click'];
    detailsId = json['detailsId'];
    auditfailed = json['auditfailed'];
    applyCount = json['applyCount'];
    shortUrl = json['shortUrl'];
    deadline = json['deadline'];
    paceLending = json['paceLending'];
    successRate = json['successRate'];
    reviewWay = json['reviewWay'];
    accountWay = json['accountWay'];
    creditrequired = json['creditrequired'];
    platformname = json['platformname'];
    interestrate = json['interestrate'];
    goodsSource=json['goodsSource'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['categoryId'] = this.categoryId;
    data['propertyIds'] = this.propertyIds;
    data['tagId'] = this.tagId;
    data['img'] = this.img;
    data['applicationrequirement'] = this.applicationrequirement;
    data['details'] = this.details;
    data['level'] = this.level;
    data['info'] = this.info;
    data['url'] = this.url;
    data['loogLine'] = this.loogLine;
    data['appoint'] = this.appoint;
    data['status'] = this.status;
    data['addTime'] = this.addTime;
    data['activation'] = this.activation;
    data['homepicture'] = this.homepicture;
    data['statusCode'] = this.statusCode;
    data['cpa'] = this.cpa;
    data['pv'] = this.pv;
    data['uv'] = this.uv;
    data['uvEarnings'] = this.uvEarnings;
    data['cpaPrice'] = this.cpaPrice;
    data['adminId'] = this.adminId;
    data['click'] = this.click;
    data['detailsId'] = this.detailsId;
    data['auditfailed'] = this.auditfailed;
    data['applyCount'] = this.applyCount;
    data['shortUrl'] = this.shortUrl;
    data['deadline'] = this.deadline;
    data['paceLending'] = this.paceLending;
    data['successRate'] = this.successRate;
    data['reviewWay'] = this.reviewWay;
    data['accountWay'] = this.accountWay;
    data['creditrequired'] = this.creditrequired;
    data['platformname'] = this.platformname;
    data['interestrate'] = this.interestrate;
    data['limit'] = this.limit;
    return data;
  }
}
