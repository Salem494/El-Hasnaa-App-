

import 'dart:convert';
import 'package:elhasnaa/data_model/cart_model.dart';
import 'package:elhasnaa/data_model/products.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CartRepo{

  List<CartModel> _cart = [];

  Future<String> addCart({required String productsId,quant,colr,size}) async{
    //  var post_body = jsonEncode({
    //   "id": productsId,
    //   "variant": "$variant",
    //   "user_id": "$user_id",
    //   "quantity": "$quantity",
    //   "cost_matrix": AppConfig.purchase_code
    // });

    String url = 'https://alhasnaa.site/api/add_prod_to_cart.php?user_id=${user_id.$}&prod_id=$productsId&prod_num=$quant&prod_size=$size&prod_color=$colr';

    Response response = await http.get(Uri.parse(url),
    );
    if(response.statusCode == 200){
      //  print(colr);
      //  print('add to carrrrd successssss  ${response.body}');
      //  print('PROOOO:${Products.fromJson(json.decode(response.body))}');
      //Products.fromJson(json.decode(response.body));
      return "200";
    }else{
      print(response.statusCode);
      return "400";
    }
  }

  Future<List<CartModel>> fetchCartUser() async{

    String url= 'https://alhasnaa.site/api/get_user_cart.php?user_id=${user_id.$}';
    Response response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      var body = json.decode(response.body);



      for(var oneCart in body){
        _cart.add(CartModel.fromJson(oneCart));
      }
      print('ONECart :${_cart.length}');
      //print('ONECart :${_cart[0].id}');

    }else{
      print(response.statusCode);
    }
    return _cart;
  }



  Future<String> getCartDeleteResponse(String prodId) async {
    Uri url = Uri.parse("https://alhasnaa.site/api/delete_cart.php?user_id=${user_id.$}&prod_id=$prodId");
    final response = await http.delete(
      url,
    );

    if(response.statusCode==200){

      // print('deletttte responseee${response.body}');
      return response.body.toString();
    }
    else{
      return response.body.toString();
    }
  }

}
//Success