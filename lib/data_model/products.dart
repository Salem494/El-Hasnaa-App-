import 'package:elhasnaa/data_model/brands.dart';

class Products {
  String? id;
  String? userId;
  String? compId;
  String? prodSort;
  String? catId1;
  String? catId2;
  String? catId3;
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
  String? prodPrice;
  String? prodPriceOld;
  String? archive;
  String? prodNo;
  String? prodVid;
  String? allVideoUrl;
  String? isOffer;
  List<dynamic>? images;
  List<String>? colors;
  List<String>? size;
  Products(
      {
        this.id,
        this.userId,
        this.compId,
        this.prodSort,
        this.catId1,
        this.catId2,
        this.catId3,
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
        this.prodPrice,
        this.prodPriceOld,
        this.archive,
        this.prodNo,
        this.prodVid,
        this.allVideoUrl,
        this.isOffer,
        this.images,
        this.colors,
        this.size});

  factory Products.fromJson(Map<String, dynamic> json)=>Products(
      id : json['id'],
      userId : json['user_id'],
      compId : json['comp_id'],
      prodSort : json['prod_sort'],
      catId1 : json['cat_id1'],
      catId2 : json['cat_id2'],
      catId3 : json['cat_id3'],
      catNameAr1 : json['cat_name_ar1'],
      catNameEn1 : json['cat_name_en1'],
      catNameTr1 : json['cat_name_tr1'],
      catNameAr2 : json['cat_name_ar2'],
      catNameEn2 : json['cat_name_en2'],
      catNameTr2 : json['cat_name_tr2'],
      catNameAr3 : json['cat_name_ar3'],
      catNameEn3 : json['cat_name_en3'],
      catNameTr3 : json['cat_name_tr3'],
      brandId : json['brand_id'],
      brandNameAr : json['brand_name_ar'],
      brandNameEn : json['brand_name_en'],
      brandNameTr : json['brand_name_tr'],
      prodNameAr : json['prod_name_ar'],
      prodNameEn : json['prod_name_en'],
      prodNameTr : json['prod_name_tr'],
      prodDescAr : json['prod_desc_ar']== null || json["prod_desc_ar"] == "" ? "لا يوجد وصف " : json['prod_desc_ar'],
      prodDescEn : json['prod_desc_en']== null || json["prod_desc_en"] == "" ? "No Description is available" : json['prod_desc_en'],
      prodDescTr : json['prod_desc_tr']== null || json["prod_desc_tr"] == "" ? "Açıklama yok" : json['prod_desc_tr'],
      prodKud : json['prod_kud'],
      prodImg : json['prod_img'],
      prodAct : json['prod_act'],
      prodPrice : json['prod_price'],
      prodPriceOld : json['prod_price_old'],
      archive : json['archive'],
      prodNo : json['prod_no'],
      prodVid : json['prod_vid'],
      allVideoUrl : json['all_video_url'],
      isOffer : json['is_offer'],
      images : List<String>.from(json["images"].map((x) => x)),
      colors :List<String>.from(json["colors"].map((x) => x)),
      size : List<String>.from(json["size"].map((x) => x))
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['comp_id'] = compId;
    data['prod_sort'] = prodSort;
    data['cat_id1'] = catId1;
    data['cat_id2'] = catId2;
    data['cat_id3'] = catId3;
    data['cat_name_ar1'] = catNameAr1;
    data['cat_name_en1'] = catNameEn1;
    data['cat_name_tr1'] = catNameTr1;
    data['cat_name_ar2'] = catNameAr2;
    data['cat_name_en2'] = catNameEn2;
    data['cat_name_tr2'] = catNameTr2;
    data['cat_name_ar3'] = catNameAr3;
    data['cat_name_en3'] = catNameEn3;
    data['cat_name_tr3'] = catNameTr3;
    data['brand_id'] = brandId;
    data['brand_name_ar'] = brandNameAr;
    data['brand_name_en'] = brandNameEn;
    data['brand_name_tr'] = brandNameTr;
    data['prod_name_ar'] = prodNameAr;
    data['prod_name_en'] = prodNameEn;
    data['prod_name_tr'] = prodNameTr;
    data['prod_desc_ar'] = prodDescAr;
    data['prod_desc_en'] = prodDescEn;
    data['prod_desc_tr'] = prodDescTr;
    data['prod_kud'] = prodKud;
    data['prod_img'] = prodImg;
    data['prod_act'] = prodAct;
    data['prod_price'] = prodPrice;
    data['prod_price_old'] = prodPriceOld;
    data['archive'] = archive;
    data['prod_no'] = prodNo;
    data['prod_vid'] = prodVid;
    data['all_video_url'] = allVideoUrl;
    data['is_offer'] = isOffer;
    data['images'] = List<dynamic>.from(images!.map((x) => x));
    data['colors'] = List<dynamic>.from(colors!.map((x) => x));
    data['size'] = List<dynamic>.from(size!.map((x) => x));
    return data;
  }
}