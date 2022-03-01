// ignore: file_names
import 'dart:convert';
import 'package:elhasnaa/data_model/brands.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class BrandsRepo {
  Future<List<Brands>?> fetchBrands() async {
    String url = 'https://alhasnaa.site/api/get_brands.php';
    Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Susssssssesssss');

      var body = jsonDecode(response.body);
      List<Brands> brands = [];

      for (var cat in body) {
        brands.add(Brands.fromJson(cat));
      }
      print('Catttttt:${brands[2].catNameAr}');
      return brands;
    } else {
      print(response.statusCode);
    }
    return null;
  }


  Future<List<Brands>?> fetchBrandDetails(String countryId,brandId) async {
    String url = 'https://alhasnaa.site/api/get_brand_products.php?country_id=${countryId}&brand_id=${brandId}';
    Response response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        print('Booooooody:${body}');
        final List<Brands> brandd = [];
        for (var brand in body) {
          brandd.add(Brands.fromJson(brand));
        }
        return brandd;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      throw Exception('Error :${e}');
    }
  }
}