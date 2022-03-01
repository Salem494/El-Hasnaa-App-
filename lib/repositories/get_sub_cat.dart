import 'dart:convert';
import 'package:elhasnaa/data_model/category_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class GetSubCategories{

  Future<List<Categories>?> fetchOneCat(String idCat) async {
    String url = 'https://alhasnaa.site/api/get_one_cat.php?cat_id=${idCat}';
    Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //print('Susssssssesssss');
      var body = jsonDecode(response.body);
      List<Categories> cats = [];
      for(var cat in body){
        cats.add(Categories.fromJson(cat));
      }
      //print('Catttttt:${cats[0].catNameAr}');
      return cats;
    } else {
      //print(response.statusCode);
    }
    return null;
  }

}