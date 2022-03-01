import 'package:elhasnaa/data_model/language_list_response.dart';
import 'package:elhasnaa/dummy_data/languages.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LanguageRepository {
  Future<LanguageListResponse> getLanguageList() async {
    // Uri url = Uri.parse(
    //     "${AppConfig.BASE_URL}/languages");
    // final response = await http.get(url,headers: {
    //   "App-Language": app_language.$,
    // }
    // );
    final response=appLanguages;
    //print(response.body.toString());
    return languageListResponseFromJson(response);
  }


}
