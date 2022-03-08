

import 'dart:convert';
import 'package:elhasnaa/data_model/fav_model.dart';
import 'package:elhasnaa/data_model/products.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


class Favorites{

  List<FavModel> wishList=[];

  Future<bool> addFavourite(String prodId) async{
    final String url = 'https://alhasnaa.site/api/add_to_favorite.php?user_id=${user_id.$}&prod_id=${prodId}';

    Response response = await http.get(Uri.parse(url),);
    if(response.statusCode == 200){
      //print('add to favvvvvvvvv successssss  ${response.body}');
      //print('Favv:${Products.fromJson(json.decode(response.body))}');
      // Products.fromJson(json.decode(response.body));
      return true;
    }else{
      print(response.statusCode);
      return false;
    }
  }

  Future<List<FavModel>> getWishList(String userId)async{
    String url ='https://alhasnaa.site/api/get_favorite_products.php?user_id=${user_id.$}';
    final response =
    await http.get(Uri.parse(url));
    if(response.statusCode==200){
      var res= json.decode(response.body);
      for (var item in res) {
        // print('itemmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
        // print('\n \n \n');
        // print(item);
        wishList.add(FavModel.fromJson(item));
      }
    }
    //print(response.body.toString());
    //print("--featured cat--");
    //return categoryResponseFromJson(response.body);
    // print("Cat List in cat repo");
    //print(catgs[0].catId);
    return wishList;
  }

  Future<bool> removeFavourite(String favId) async {
    String url = "https://alhasnaa.site/api/delete_favorite.php?id=$favId";
    Response response = await http.delete(Uri.parse(url));

    if(response.statusCode==200){

      print('deletttte responseee${response.body}');
      return true;
    }
    else{
      return false;
    }
  }
}
