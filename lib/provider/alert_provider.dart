
import 'package:elhasnaa/data_model/country.dart';
import 'package:flutter/cupertino.dart';

class AlertProvider extends ChangeNotifier {

 late Country dropdownValue = Country(id: '0', countryName: 'Select Country');

  void changeValue(val){
    dropdownValue = val;
    notifyListeners();
  }

}