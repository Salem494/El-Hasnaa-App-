class SliderModel {
  String? sliderId;
  String? userId;
  String? compId;
  String? tarteb;
  String? sliderPhoto;
  String? text1Ar;
  String? text2Ar;
  String? text3Ar;
  String? text1En;
  String? text2En;
  String? text3En;
  String? text1Tr;
  String? text2Tr;
  String? text3Tr;
  String? btnUrl;
  String? sliderSet;

  SliderModel(
      {this.sliderId,
        this.userId,
        this.compId,
        this.tarteb,
        this.sliderPhoto,
        this.text1Ar,
        this.text2Ar,
        this.text3Ar,
        this.text1En,
        this.text2En,
        this.text3En,
        this.text1Tr,
        this.text2Tr,
        this.text3Tr,
        this.btnUrl,
        this.sliderSet});

  SliderModel.fromJson(Map<String, dynamic> json) {
    sliderId = json['slider_id'];
    userId = json['user_id'];
    compId = json['comp_id'];
    tarteb = json['tarteb'];
    sliderPhoto = json['slider_photo'];
    text1Ar = json['text_1_ar'];
    text2Ar = json['text_2_ar'];
    text3Ar = json['text_3_ar'];
    text1En = json['text_1_en'];
    text2En = json['text_2_en'];
    text3En = json['text_3_en'];
    text1Tr = json['text_1_tr'];
    text2Tr = json['text_2_tr'];
    text3Tr = json['text_3_tr'];
    btnUrl = json['btn_url'];
    sliderSet = json['slider_set'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slider_id'] = this.sliderId;
    data['user_id'] = this.userId;
    data['comp_id'] = this.compId;
    data['tarteb'] = this.tarteb;
    data['slider_photo'] = this.sliderPhoto;
    data['text_1_ar'] = this.text1Ar;
    data['text_2_ar'] = this.text2Ar;
    data['text_3_ar'] = this.text3Ar;
    data['text_1_en'] = this.text1En;
    data['text_2_en'] = this.text2En;
    data['text_3_en'] = this.text3En;
    data['text_1_tr'] = this.text1Tr;
    data['text_2_tr'] = this.text2Tr;
    data['text_3_tr'] = this.text3Tr;
    data['btn_url'] = this.btnUrl;
    data['slider_set'] = this.sliderSet;
    return data;
  }
}