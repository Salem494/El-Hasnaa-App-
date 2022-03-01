

 import 'dart:convert';

import 'package:elhasnaa/data_model/user.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future fetchRegister(User user) async{
      String url = 'https://alhasnaa.site/api/registration.php?user_name=${user.userName}&country=${user.country}&country_zip=${user.countryZip}&user_phone=${user.userPhone}&user_mail=${user.userMail}&password=${user.password}';

      Response response = await http.get(Uri.parse(url));

      if(response.statusCode == 200){
        print(response.statusCode);
        print('SSSSSSSSS:${User.fromJson(json.decode(response.body))}');
          return User.fromJson(json.decode(response.body));
      }else{
        print(response.statusCode);
      }

 }