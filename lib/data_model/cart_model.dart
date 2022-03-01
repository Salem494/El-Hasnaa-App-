class CartModel {
  String? id;
  String? prodId;
  String? userId;
  String? compId;
  String? prodSort;
  String? catId1;
  String? catId2;
  String? catId3;
  String? countryId;
  String? catNameAr1;
  String? catNameEn1;
  String? catNameTr1;
  String? catNameAr2;
  String? catNameEn2;
  String? catNameTr2;
  String? catNameAr3;
  String? catNameEn3;
  String? catNameTr3;
  String? brandId;
  String? brandNameAr;
  String? brandNameEn;
  String? brandNameTr;
  String? prodNameAr;
  String? prodNameEn;
  String? prodNameTr;
  String? prodDescAr;
  String? prodDescEn;
  String? prodDescTr;
  String? prodKud;
  String? prodImg;
  String? prodAct;
  String? archive;
  String? prodPrice;
  String? prodPriceOld;
  String? prodNo;
  String? prodVid;
  String? allVideoUrl;
  String? isOffer;
  String? ip;
  String? total;
  String? addDate;
  String? basketSet;
  String? orderId;
  String? prodColor;
  String? prodSize;
  String? coinId;
  String? userMac;

  CartModel(
      {this.id,
        this.prodId,
        this.userId,
        this.compId,
        this.prodSort,
        this.catId1,
        this.catId2,
        this.catId3,
        this.countryId,
        this.catNameAr1,
        this.catNameEn1,
        this.catNameTr1,
        this.catNameAr2,
        this.catNameEn2,
        this.catNameTr2,
        this.catNameAr3,
        this.catNameEn3,
        this.catNameTr3,
        this.brandId,
        this.brandNameAr,
        this.brandNameEn,
        this.brandNameTr,
        this.prodNameAr,
        this.prodNameEn,
        this.prodNameTr,
        this.prodDescAr,
        this.prodDescEn,
        this.prodDescTr,
        this.prodKud,
        this.prodImg,
        this.prodAct,
        this.archive,
        this.prodPrice,
        this.prodPriceOld,
        this.prodNo,
        this.prodVid,
        this.allVideoUrl,
        this.isOffer,
        this.ip,
        this.total,
        this.addDate,
        this.basketSet,
        this.orderId,
        this.prodColor,
        this.prodSize,
        this.coinId,
        this.userMac});

  factory CartModel.fromJson(Map<String, dynamic> json) =>CartModel(
      id: json['id'],
      prodId: json['prod_id'],
      userId: json['user_id'],
      compId: json['comp_id'],
      prodSort: json['prod_sort'],
      catId1: json['cat_id1'],
      catId2: json['cat_id2'],
      catId3: json['cat_id3'],
      countryId: json['country_id'],
      catNameAr1: json['cat_name_ar1'],
      catNameEn1: json['cat_name_en1'],
      catNameTr1: json['cat_name_tr1'],
      catNameAr2: json['cat_name_ar2'],
      catNameEn2: json['cat_name_en2'],
      catNameTr2: json['cat_name_tr2'],
      catNameAr3: json['cat_name_ar3'],
      catNameEn3: json['cat_name_en3'],
      catNameTr3: json['cat_name_tr3'],
      brandId: json['brand_id'],
      brandNameAr: json['brand_name_ar'],
      brandNameEn: json['brand_name_en'],
      brandNameTr: json['brand_name_tr'],
      prodNameAr: json['prod_name_ar'],
      prodNameEn: json['prod_name_en'],
      prodNameTr: json['prod_name_tr'],
      prodDescAr: json['prod_desc_ar'],
      prodDescEn: json['prod_desc_en'],
      prodDescTr: json['prod_desc_tr'],
      prodKud: json['prod_kud'],
      prodImg: json['prod_img'],
      prodAct: json['prod_act'],
      archive: json['archive'],
      prodPrice: json['prod_price'],
      prodPriceOld: json['prod_price_old'],
      prodNo: json['prod_no'],
      prodVid: json['prod_vid'],
      allVideoUrl: json['all_video_url'],
      isOffer: json['is_offer'],
      ip: json['ip'],
      total: json['total'],
      addDate: json['add_date'],
      basketSet: json['basket_set'],
      orderId: json['order_id'],
      prodColor: json['prod_color'],
      prodSize: json['prod_size'],
      coinId: json['coin_id'],
      userMac: json['user_mac']
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prod_id'] = this.prodId;
    data['user_id'] = this.userId;
    data['comp_id'] = this.compId;
    data['prod_sort'] = this.prodSort;
    data['cat_id1'] = this.catId1;
    data['cat_id2'] = this.catId2;
    data['cat_id3'] = this.catId3;
    data['country_id'] = this.countryId;
    data['cat_name_ar1'] = this.catNameAr1;
    data['cat_name_en1'] = this.catNameEn1;
    data['cat_name_tr1'] = this.catNameTr1;
    data['cat_name_ar2'] = this.catNameAr2;
    data['cat_name_en2'] = this.catNameEn2;
    data['cat_name_tr2'] = this.catNameTr2;
    data['cat_name_ar3'] = this.catNameAr3;
    data['cat_name_en3'] = this.catNameEn3;
    data['cat_name_tr3'] = this.catNameTr3;
    data['brand_id'] = this.brandId;
    data['brand_name_ar'] = this.brandNameAr;
    data['brand_name_en'] = this.brandNameEn;
    data['brand_name_tr'] = this.brandNameTr;
    data['prod_name_ar'] = this.prodNameAr;
    data['prod_name_en'] = this.prodNameEn;
    data['prod_name_tr'] = this.prodNameTr;
    data['prod_desc_ar'] = this.prodDescAr;
    data['prod_desc_en'] = this.prodDescEn;
    data['prod_desc_tr'] = this.prodDescTr;
    data['prod_kud'] = this.prodKud;
    data['prod_img'] = this.prodImg;
    data['prod_act'] = this.prodAct;
    data['archive'] = this.archive;
    data['prod_price'] = this.prodPrice;
    data['prod_price_old'] = this.prodPriceOld;
    data['prod_no'] = this.prodNo;
    data['prod_vid'] = this.prodVid;
    data['all_video_url'] = this.allVideoUrl;
    data['is_offer'] = this.isOffer;
    data['ip'] = this.ip;
    data['total'] = this.total;
    data['add_date'] = this.addDate;
    data['basket_set'] = this.basketSet;
    data['order_id'] = this.orderId;
    data['prod_color'] = this.prodColor;
    data['prod_size'] = this.prodSize;
    data['coin_id'] = this.coinId;
    data['user_mac'] = this.userMac;
    return data;
  }
}