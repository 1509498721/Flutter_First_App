class ScreenModel {
  List<ScreenCashAmount> cashAmount;
  List<ScreenDeadLine> deadLine;
  List<ScreenCompositeRank> compositeRank;

  ScreenModel({this.cashAmount, this.deadLine, this.compositeRank});

  ScreenModel.fromJson(Map<String, dynamic> json) {
    if (json['cashAmount'] != null) {
      cashAmount = new List<ScreenCashAmount>();
      json['cashAmount'].forEach((v) {
        cashAmount.add(new ScreenCashAmount.fromJson(v));
      });
    }
    if (json['deadLine'] != null) {
      deadLine = new List<ScreenDeadLine>();
      json['deadLine'].forEach((v) {
        deadLine.add(new ScreenDeadLine.fromJson(v));
      });
    }
    if (json['compositeRank'] != null) {
      compositeRank = new List<ScreenCompositeRank>();
      json['compositeRank'].forEach((v) {
        compositeRank.add(new ScreenCompositeRank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cashAmount != null) {
      data['cashAmount'] = this.cashAmount.map((v) => v.toJson()).toList();
    }
    if (this.deadLine != null) {
      data['deadLine'] = this.deadLine.map((v) => v.toJson()).toList();
    }
    if (this.compositeRank != null) {
      data['compositeRank'] =
          this.compositeRank.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScreenCashAmount {
  int indexMoney;
  int id;
  String moneyname;
  String addTime;

  ScreenCashAmount({this.indexMoney, this.id, this.moneyname, this.addTime});

  ScreenCashAmount.fromJson(Map<String, dynamic> json) {
    indexMoney = json['indexMoney'];
    id = json['id'];
    moneyname = json['moneyname'];
    addTime = json['addTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['indexMoney'] = this.indexMoney;
    data['id'] = this.id;
    data['moneyname'] = this.moneyname;
    data['addTime'] = this.addTime;
    return data;
  }
}

class ScreenDeadLine {
  int id;
  String term;
  int indexLoan;

  ScreenDeadLine({this.id, this.term, this.indexLoan});

  ScreenDeadLine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    term = json['term'];
    indexLoan = json['indexLoan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['term'] = this.term;
    data['indexLoan'] = this.indexLoan;
    return data;
  }
}

class ScreenCompositeRank {
  int id;
  String title;
  String img;
  int level;
  String addTime;

  ScreenCompositeRank({this.id, this.title, this.img, this.level, this.addTime});

  ScreenCompositeRank.fromJson(Map<String, dynamic> json) {
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

