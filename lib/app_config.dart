import 'package:flutter/material.dart';

var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text = "El Hasnaa  " " " + this_year; //this shows in the splash screen
  static String app_name = "El Hasnaa"; //this shows in the splash screen
  //static String purchase_code = "c3bd37a0-c332-4202-bbae-a9725f9a711e"; //enter your purchase code for the app from codecanyon
  //static String purchase_code = ""; //enter your purchase code for the app from codecanyon
  //configure this
  static const bool HTTPS = true;
  //configure this

   static const DOMAIN_PATH = "alhasnaa.site"; //inside a folder
  // static const DOMAIN_PATH = "mydomain.com"; // directly inside the public folder
//demo.activeitzone.com/ecommerce_flutter_demo/api/v2
  //do not configure these below  https://alhasnaa.site/files/
  static const String API_ENDPATH = "api";
  static const String PUBLIC_FOLDER = "files";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";

  // static const String BASE_URL = "http://yk-design.org/public";
  //configure this if you are using amazon s3 like services
  //give direct link to file like https://[[bucketname]].s3.ap-southeast-1.amazonaws.com/
  //otherwise do not change anythink
  static const String BASE_PATH = "${RAW_BASE_URL}/${PUBLIC_FOLDER}/";
  //static const String BASE_PATH = "https://tosoviti.s3.ap-southeast-2.amazonaws.com/";
}
