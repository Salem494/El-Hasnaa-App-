import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:elhasnaa/data_model/get_vendors.dart';


Future<List<getVendors>?> fetchVendors() async {
  String url = 'https://alhasnaa.site/api/get_vendors.php';
  Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print('Susssssssesssss');

    var body = jsonDecode(response.body);
    List<getVendors> vendors = [];

    for(var cat in body){
      vendors.add(getVendors.fromJson(cat));
    }
    print('Veeeeeee:${vendors[2].aboutVendor}');
    return vendors;
  } else {
    print(response.statusCode);
  }
}
