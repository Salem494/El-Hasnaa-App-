import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:elhasnaa/data_model/get_vendors.dart';



 Future<List<getVendors>?> fetchOneVendor(String countryId, vendorId) async {

  String url = 'https://alhasnaa.site/api/get_vendor_products.php?country_id=${countryId}&vendor_id=${vendorId}';

  Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print('Susssssssesssss');

    var body = jsonDecode(response.body);
    print('body:${body}');

    List<getVendors> vendors = [];
    for(var cat in body){
      vendors.add(getVendors.fromJson(cat));
    }
    print('Veeeeeeeddddddddddddddor:${vendors[1].prodPrice}');
    return vendors;
  } else {
    print(response.statusCode);
  }
}
