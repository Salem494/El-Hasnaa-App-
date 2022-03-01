import 'dart:convert';
import 'package:elhasnaa/data_model/get_Country_product.dart';
import 'package:elhasnaa/data_model/products.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';

class GetOffersCategories{

  Future<List<getCountryProduct>?> fetchOffersCat(String countryId) async {
    String url = 'https://alhasnaa.site/api/get_country_products.php?country_id=${countryId}';
    Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      //print('Susssssssesssss');
      var body = jsonDecode(response.body);
      List<getCountryProduct> cats = [];
      for(var cat in body){
        cats.add(getCountryProduct.fromJson(cat));
      }

      return cats;
    } else {
      //print(response.statusCode);
    }
    return null;
  }
}