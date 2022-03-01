class Country {
  String? id;
  String? userId;
  String? compId;
  String? catId;
  String? catNameAr;
  String? coinPrice;
  String? countryName;
  String? flag;
  String? lang;
  String? catImg;
  String? catIcone;
  String? catAct;
  String? catSort;
  String? archive;
  String? countryNameEn;
  String? countryNameTr;

  Country(
      {this.id,
        this.userId,
        this.compId,
        this.catId,
        this.catNameAr,
        this.coinPrice,
        this.countryName,
        this.flag,
        this.lang,
        this.catImg,
        this.catIcone,
        this.catAct,
        this.catSort,
        this.archive,
        this.countryNameEn,
        this.countryNameTr});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    compId = json['comp_id'];
    catId = json['cat_id'];
    catNameAr = json['cat_name_ar'];
    coinPrice = json['coin_price'];
    countryName = json['country_name'];
    flag = json['flag'];
    lang = json['lang'];
    catImg = json['cat_img'];
    catIcone = json['cat_icone'];
    catAct = json['cat_act'];
    catSort = json['cat_sort'];
    archive = json['archive'];
    countryNameEn = json['country_name_en'];
    countryNameTr = json['country_name_tr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['comp_id'] = this.compId;
    data['cat_id'] = this.catId;
    data['cat_name_ar'] = this.catNameAr;
    data['coin_price'] = this.coinPrice;
    data['country_name'] = this.countryName;
    data['flag'] = this.flag;
    data['lang'] = this.lang;
    data['cat_img'] = this.catImg;
    data['cat_icone'] = this.catIcone;
    data['cat_act'] = this.catAct;
    data['cat_sort'] = this.catSort;
    data['archive'] = this.archive;
    data['country_name_en'] = this.countryNameEn;
    data['country_name_tr'] = this.countryNameTr;
    return data;
  }
}