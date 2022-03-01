import 'dart:convert';
import 'package:elhasnaa/data_model/products.dart';
import 'package:elhasnaa/data_model/related_product.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ProductsResponse{
  Future<List<Products>> fetchProducts(String catId) async {
    Uri url =Uri.parse('https://alhasnaa.site/api/get_prod_data.php?prod_id=$catId');
    Response response = await http.get(url);
    List<Products> cats = [];

    if (response.statusCode == 200) {
      //print('Susssssssesssss');

      var body = json.decode(response.body);//sonDecode(response.body);
      // print("productssssssssssssssssssss");
      // print('\n\n\n\n');
      // print('rrrrrrrr'+body.toString());
      for(var cat in body){
        cats.add(Products.fromJson(cat));
        print('vvvvvvvvvvvvvvvvvvvvvvvvvvv');
        //print(Products.fromJson(cat).images![0]);

      }
      //print('Catttttt:${cats.length}');    //23  sucessful
      // print('Catttttt:${cats[2].prodId}');    //24  sucessful
      // return cats;
    } else {
      //print(response.statusCode);
    }
    //print(cats[0].images![1]);
    return cats;
  }


  Future<List<RelatedProducts>> fetchRelatedProd(String prodId,String countId) async {
    Uri url =Uri.parse('https://alhasnaa.site/api/get_similar_products.php?prod_id=$prodId&country_id=$countId');
    Response response = await http.get(url);
    List<RelatedProducts> relProd = [];

    if (response.statusCode == 200) {
      //print('Susssssssesssss');

      var body = json.decode(response.body);//sonDecode(response.body);

      for(var pro in body){
        relProd.add(RelatedProducts.fromJson(pro));
      }

    } else {
      //print(response.statusCode);
    }
    //print(cats[0].images![1]);
    return relProd;
  }

//  Future<List<Products>> fetchCountrySubSubCP(String? catId,CountryId) async {
//   Uri url =Uri.parse('https://alhasnaa.site/api/get_country_sub_subcategory_products.php?country_id=1&cat_id=$catId');
//   Response response = await http.get(url);
//   List<Products> cats = [];

//   if (response.statusCode == 200) {

//     var body = json.decode(response.body);
//     for(var cat in body){
//       cats.add(Products.fromJson(cat));

//     }

//     return cats;
//   } else {
//     //print(response.statusCode);
//   }
//   return cats;
// }

}