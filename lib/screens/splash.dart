import 'dart:async';

import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/screens/main.dart';
import 'package:elhasnaa/screens/register_screen.dart';
import 'package:elhasnaa/screens/registration.dart';
import 'package:elhasnaa/ui_elements/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:elhasnaa/helpers/shared_value_helper.dart';

import 'login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5),(){
             //RegisterScreen()
      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen(),),);

    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body:  Container(
        color: Colors.white38,
        height: double.infinity,
        width: double.infinity,
        child: Image.asset('assets/1.jpg',width: 250),
      ),
    );
  }
}
