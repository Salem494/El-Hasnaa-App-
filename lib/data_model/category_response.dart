class Categories {
  String? id;
  String? userId;
  String? compId;
  String? catId;
  String? catNameAr;
  String? catNameEn;
  String? catNameTr;
  String? catTextAr;
  String? catTextEn;
  String? catImg;
  String? catIcone;
  String? smCatIcone;
  String? catAct;
  String? catSort;
  String? archive;
  String? showHome;
  String? showHomeTime;
  String? catImgSm;

  Categories(
      {this.id,
      this.userId,
      this.compId,
      this.catId,
      this.catNameAr,
      this.catNameEn,
      this.catNameTr,
      this.catTextAr,
      this.catTextEn,
      this.catImg,
      this.catIcone,
      this.smCatIcone,
      this.catAct,
      this.catSort,
      this.archive,
      this.showHome,
      this.showHomeTime,
      this.catImgSm});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    compId = json['comp_id'];
    catId = json['cat_id'];
    catNameAr = json['cat_name_ar'];
    catNameEn = json['cat_name_en'];
    catNameTr = json['cat_name_tr'];
    catTextAr = json['cat_text_ar'];
    catTextEn = json['cat_text_en'];
    catImg = json['cat_img'];
    catIcone = json['cat_icone'];
    smCatIcone = json['sm_cat_icone'];
    catAct = json['cat_act'];
    catSort = json['cat_sort'];
    archive = json['archive'];
    showHome = json['show_home'];
    showHomeTime = json['show_home_time'];
    catImgSm = json['cat_img_sm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['comp_id'] = compId;
    data['cat_id'] = catId;
    data['cat_name_ar'] = catNameAr;
    data['cat_name_en'] = catNameEn;
    data['cat_name_tr'] = catNameTr;
    data['cat_text_ar'] = catTextAr;
    data['cat_text_en'] = catTextEn;
    data['cat_img'] = catImg;
    data['cat_icone'] = catIcone;
    data['sm_cat_icone'] = smCatIcone;
    data['cat_act'] = catAct;
    data['cat_sort'] = catSort;
    data['archive'] = archive;
    data['show_home'] = showHome;
    data['show_home_time'] = showHomeTime;
    data['cat_img_sm'] = catImgSm;
    return data;
  }
}