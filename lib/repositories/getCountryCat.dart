
import 'dart:convert';
import 'package:elhasnaa/data_model/country.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class CountryRepo{
late List<Country> Countrycats = [];
Future<List<Country>> fetchCountryCat() async {
  String url = 'https://alhasnaa.site/api/get_countries.php';
  Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    //print('Susssssssesssss');
    var body = jsonDecode(response.body);
    for(var cat in body){
      Countrycats.add(Country.fromJson(cat));
    }
   // print('Catttttt:${Countrycats[0].catNameAr}');
    return Countrycats;
  } else {
    print(response.statusCode);
  }
  return [];
}


}
