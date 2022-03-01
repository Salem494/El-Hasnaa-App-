import 'dart:convert';
import 'package:elhasnaa/data_model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;



  Future fetchLogin(User user) async{

    String url = 'https://alhasnaa.site/api/login.php?phone_email=${user.userPhone}&password=${user.password}';
    Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var body = json.decode(response.body);
      print(body);
    }else{
      print(response.statusCode);
    }
  }



