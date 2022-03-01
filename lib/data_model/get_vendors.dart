

class getVendors {
  String? id;
  String? vendorId;
  String? vendorName;
  String? vendorNameEn;
  String? vendorNameTr;
  String? vendorEmail;
  String? sclose;
  String? stextclose;
  String? feacbook;
  String? tweter;
  String? inestgram;
  String? youtube;
  String? linkedin;
  String? googlePlus;
  String? wUp;
  String? phone1;
  String? phone2;
  String? fax;
  String? phoneCenter;
  String? pbox;
  String? reklam;
  String? siteMap;
  String? siteAddress;
  String? logo;
  String? favicon;
  String? editTime;
  String? mclose;
  String? mText;
  String? menuMode;
  String? contactEmp;
  String? coinId;
  String? addDate;
  String? archive;
  String? sort;
  String? vendorAct;
  String? aboutVendor;
  String? banner;
  String? vendorSet;
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
  String? prodPrice;
  String? prodPriceOld;
  String? prodNo;
  String? prodVid;
  String? allVideoUrl;
  String? isOffer;

  getVendors(
      {this.id,
        this.vendorId,
        this.vendorName,
        this.vendorNameEn,
        this.vendorNameTr,
        this.vendorEmail,
        this.sclose,
        this.stextclose,
        this.feacbook,
        this.tweter,
        this.inestgram,
        this.youtube,
        this.linkedin,
        this.googlePlus,
        this.wUp,
        this.phone1,
        this.phone2,
        this.fax,
        this.phoneCenter,
        this.pbox,
        this.reklam,
        this.siteMap,
        this.siteAddress,
        this.logo,
        this.favicon,
        this.editTime,
        this.mclose,
        this.mText,
        this.menuMode,
        this.contactEmp,
        this.coinId,
        this.addDate,
        this.archive,
        this.sort,
        this.vendorAct,
        this.aboutVendor,
        this.banner,
        this.vendorSet,

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
        this.prodPrice,
        this.prodPriceOld,
        this.prodNo,
        this.prodVid,
        this.allVideoUrl,
        this.isOffer
      });

  getVendors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    vendorNameEn = json['vendor_name_en'];
    vendorNameTr = json['vendor_name_tr'];
    vendorEmail = json['vendor_email'];
    sclose = json['sclose'];
    stextclose = json['stextclose'];
    feacbook = json['feacbook'];
    tweter = json['tweter'];
    inestgram = json['inestgram'];
    youtube = json['youtube'];
    linkedin = json['linkedin'];
    googlePlus = json['google_plus'];
    wUp = json['w_up'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    fax = json['fax'];
    phoneCenter = json['phone_center'];
    pbox = json['pbox'];
    reklam = json['reklam'];
    siteMap = json['site_map'];
    siteAddress = json['site_address'];
    logo = json['logo'];
    favicon = json['favicon'];
    editTime = json['edit_time'];
    mclose = json['mclose'];
    mText = json['m_text'];
    menuMode = json['menu_mode'];
    contactEmp = json['contact_emp'];
    coinId = json['coin_id'];
    addDate = json['add_date'];
    archive = json['archive'];
    sort = json['sort'];
    vendorAct = json['vendor_act'];
    aboutVendor = json['about_vendor'];
    banner = json['banner'];
    vendorSet = json['vendor_set'];
    prodId = json['prod_id'];
    userId = json['user_id'];
    compId = json['comp_id'];
    prodSort = json['prod_sort'];
    catId1 = json['cat_id1'];
    catId2 = json['cat_id2'];
    catId3 = json['cat_id3'];
    countryId = json['country_id'];
    catNameAr1 = json['cat_name_ar1'];
    catNameEn1 = json['cat_name_en1'];
    catNameTr1 = json['cat_name_tr1'];
    catNameAr2 = json['cat_name_ar2'];
    catNameEn2 = json['cat_name_en2'];
    catNameTr2 = json['cat_name_tr2'];
    catNameAr3 = json['cat_name_ar3'];
    catNameEn3 = json['cat_name_en3'];
    catNameTr3 = json['cat_name_tr3'];
    brandId = json['brand_id'];
    brandNameAr = json['brand_name_ar'];
    brandNameEn = json['brand_name_en'];
    brandNameTr = json['brand_name_tr'];
    prodNameAr = json['prod_name_ar'];
    prodNameEn = json['prod_name_en'];
    prodNameTr = json['prod_name_tr'];
    prodDescAr = json['prod_desc_ar'];
    prodDescEn = json['prod_desc_en'];
    prodDescTr = json['prod_desc_tr'];
    prodKud = json['prod_kud'];
    prodImg = json['prod_img'];
    prodAct = json['prod_act'];
    prodPrice = json['prod_price'];
    prodPriceOld = json['prod_price_old'];
    prodNo = json['prod_no'];
    prodVid = json['prod_vid'];
    allVideoUrl = json['all_video_url'];
    isOffer = json['is_offer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    data['vendor_name_en'] = this.vendorNameEn;
    data['vendor_name_tr'] = this.vendorNameTr;
    data['vendor_email'] = this.vendorEmail;
    data['sclose'] = this.sclose;
    data['stextclose'] = this.stextclose;
    data['feacbook'] = this.feacbook;
    data['tweter'] = this.tweter;
    data['inestgram'] = this.inestgram;
    data['youtube'] = this.youtube;
    data['linkedin'] = this.linkedin;
    data['google_plus'] = this.googlePlus;
    data['w_up'] = this.wUp;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['fax'] = this.fax;
    data['phone_center'] = this.phoneCenter;
    data['pbox'] = this.pbox;
    data['reklam'] = this.reklam;
    data['site_map'] = this.siteMap;
    data['site_address'] = this.siteAddress;
    data['logo'] = this.logo;
    data['favicon'] = this.favicon;
    data['edit_time'] = this.editTime;
    data['mclose'] = this.mclose;
    data['m_text'] = this.mText;
    data['menu_mode'] = this.menuMode;
    data['contact_emp'] = this.contactEmp;
    data['coin_id'] = this.coinId;
    data['add_date'] = this.addDate;
    data['archive'] = this.archive;
    data['sort'] = this.sort;
    data['vendor_act'] = this.vendorAct;
    data['about_vendor'] = this.aboutVendor;
    data['banner'] = this.banner;
    data['vendor_set'] = this.vendorSet;
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
    data['prod_price'] = this.prodPrice;
    data['prod_price_old'] = this.prodPriceOld;
    data['prod_no'] = this.prodNo;
    data['prod_vid'] = this.prodVid;
    data['all_video_url'] = this.allVideoUrl;
    data['is_offer'] = this.isOffer;
    return data;
  }
}