import 'package:elhasnaa/custom/input_decorations.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/repositories/get_login.dart';
import 'package:elhasnaa/repositories/register.dart';
import 'package:elhasnaa/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:elhasnaa/data_model/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




class Regisiteration extends StatefulWidget {
  @override
  _RegisiterationState createState() => _RegisiterationState();
}

class _RegisiterationState extends State<Regisiteration> {

  //controllers
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _countryZipController = TextEditingController();
  TextEditingController _userName = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late String phone,password,username,userMail,country,countryZip;

  @override
  void initState() {
    //on Splash Screen hide statusbar
    fetchRegister(User(
        country: _countryController.text,
        countryZip: _countryZipController.text,
        password: _passwordController.text,
        userMail: _emailController.text,
        userName: _userName.text,
        userPhone: _phoneNumberController.text
    ));
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  onPressedRegister() async {
    final form = _key.currentState;
    if(form!.validate()){
      fetchRegister(User(
        country: _countryController.text,
        countryZip: _countryZipController.text,
        password: _passwordController.text,
        userMail: _emailController.text,
        userName: _userName.text,
        userPhone: _phoneNumberController.text
      ));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Main()));
    }else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/1.jpg',width: 250),
                SizedBox(height: 10,),
                Text(' ${AppLocalizations.of(context)!.login_screen_log_in} ${AppLocalizations.of(context)!.hasnaa}',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: MyTheme.dark_grey
                ),),
                Form(
                  key:_key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 35,),
                      Center(
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            controller: _userName,
                              onSaved: (val){
                                username = val!;
                              },
                              validator: (value){
                                if(value!.isEmpty) {
                                  return AppLocalizations.of(context)!.registration_screen_name_warning;
                                }else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.registration_screen_name,
                                  border:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: MyTheme.dark_grey,
                                          width: 0.2
                                      )
                                  )
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Center(
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            controller: _emailController,
                              onSaved: (val){
                                userMail = val!;
                              },
                              validator: (value){
                                if(value!.isEmpty || !value.contains('@')) {
                                  return  AppLocalizations.of(context)!.login_screen_email_warning;
                                }else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.registration_screen_email,
                                  border:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: MyTheme.dark_grey,
                                          width: 0.2
                                      )
                                  )
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width* 0.9,
                          child: TextFormField(
                            controller: _phoneNumberController,
                              onSaved: (val){
                                phone = val!;
                              },
                              validator: (value){
                                if(value!.isEmpty || value.length < 4) {
                                  return AppLocalizations.of(context)!.login_screen_phone_warning;
                                }else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.password_forget_screen_phone,
                                  border:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: MyTheme.dark_grey,
                                          width: 0.2
                                      )
                                  )
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Center(
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width* 0.9,
                          child: TextFormField(
                            controller: _countryController,
                              onSaved: (val){
                                country = val!;
                              },
                              validator: (value){
                                if(value!.isEmpty) {
                                  return AppLocalizations.of(context)!.address_screen_enter_country;
                                }else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.address_screen_country,
                                  border:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: MyTheme.dark_grey,
                                          width: 0.2
                                      )
                                  )
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Center(
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width* 0.9,
                          child: TextFormField(
                            controller: _countryZipController,
                              onSaved: (val){
                                countryZip = val! ;
                              },
                              validator: (value){
                                if(value!.isEmpty) {
                                  return AppLocalizations.of(context)!.country_zip_waning;
                                }else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.country_zip,
                                  border:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: MyTheme.dark_grey,
                                          width: 0.2
                                      )
                                  )
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Center(
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width* 0.9,
                          child: TextFormField(
                            controller: _passwordController,
                              onSaved: (val){
                                password = val!;
                              },
                              validator: (value){
                                if(value!.isEmpty || value.length < 4) {
                                  return  AppLocalizations.of(context)!.registration_screen_password_length_warning;
                                }else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  hintText:AppLocalizations.of(context)!.login_screen_password ,
                                  border:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: MyTheme.dark_grey,
                                          width: 0.2
                                      )
                                  )
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      InkWell(
                        onTap: (){
                          onPressedRegister();
                        },
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            color: MyTheme.golden,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(AppLocalizations.of(context)!.registration_screen_log_in,style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            )),
      ),
    );
  }
}
