import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:elhasnaa/app_config.dart';
import 'package:elhasnaa/data_model/category_response.dart';

class CategoryRepository{
  List <Categories> catgs=[];

  Future<List<Categories>> getFeturedCategories() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/get_main_cats.php");
    final response =
    await http.get(url);
    // print('-----------------------------------------------');
    // print(response.body);

    if(response.statusCode==200){
      var res= json.decode(response.body);
      // print("res ********************");
      // print(res);
      for (var item in res) {
        // print('itemmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
        // print('\n \n \n');
        // print(item);
        catgs.add(Categories.fromJson(item));
      }
    }
    //print(response.body.toString());
    //print("--featured cat--");
    //return categoryResponseFromJson(response.body);
    // print("Cat List in cat repo");
    //print(catgs[0].catId);
    return catgs;
  }
}