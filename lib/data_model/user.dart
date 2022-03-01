class User {
  String? success;
  String? userId;
  String? userMail;
  String? userName;
  String? country;
  String? countryZip;
  String? userPhone;
  String? password;

  User({this.success, this.userId, this.userMail, this.userName,this.country,this.countryZip,this.userPhone,this.password});

  User.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    userId = json['user_id'];
    userMail = json['user_mail'];
    userName = json['user_name'];
    country = json['country'];
    countryZip = json['country_zip'];
    userPhone = json['user_phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['user_id'] = this.userId;
    data['user_mail'] = this.userMail;
    data['user_name'] = this.userName;
    data['country'] = this.country;
    data['country_zip'] = this.countryZip;
    data['user_phone'] = this.userPhone;
    data['password'] = this.password;
    return data;
  }
}