import 'dart:convert';
import 'package:elhasnaa/data_model/get_cart_user.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<List<getCartUser>?> fetchCartUser(String userId,prodId) async{

  String url= 'https://alhasnaa.site/api/get_user_cart.php?user_id=${userId}&prod_id=${prodId}';
   Response response = await http.get(Uri.parse(url));

   if(response.statusCode == 200){
     var body = json.decode(response.body);

     List<getCartUser> cart = [];

      for(var oneCart in body){
        cart.add(getCartUser.fromJson(oneCart));
      }
      print('ONECart :${cart.length}');
      print('ONECart :${cart[0].id}');
     return cart;
   }else{
     print(response.statusCode);
   }
}