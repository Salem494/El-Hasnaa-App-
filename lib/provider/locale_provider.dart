import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';


class LocaleProvider with ChangeNotifier{
  late Locale _locale;
  Locale get locale {
    return _locale =  Locale(app_mobile_language.$,'');
  }

  void setLocale(String code){
    _locale = Locale(code,'');
    notifyListeners();
  }
}