import 'package:elhasnaa/custom/input_decorations.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/repositories/get_login.dart';
import 'package:elhasnaa/screens/main.dart';
import 'package:elhasnaa/screens/registration.dart';
import 'package:elhasnaa/screens/select_country_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:elhasnaa/data_model/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //controllers
  TextEditingController _phoneNumberController = TextEditingController();
//  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late String phone,password;

  @override
  void initState() {
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

  onPressedLogin() async {
    final form = _key.currentState;
   if(form!.validate()){
     phone = _phoneNumberController.text.toString();
     password = _passwordController.text.toString();
     fetchLogin(User(
       userPhone: _phoneNumberController.text.toString(),
       password: _passwordController.text.toString()
     ));

     if(is_logged_in.$){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectCountry()));
     }else{
       Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
     }

     print(_phoneNumberController.text);
//     print(_phoneNumberController.text);
   }else {
     return null;
   }
  }

  bool obscure = true;


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
                Text(' ${ AppLocalizations.of(context)!.login_screen_log_in}  ${AppLocalizations.of(context)!.hasnaa}',style: TextStyle(
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
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            enabled: true,
                            keyboardType: TextInputType.phone,
                            onSaved: (val){
                              phone = val!;
                            },
                              validator: (value){
                                if(value!.isEmpty || value.length < 4) {
                                  return  AppLocalizations.of(context)!.registration_screen_phone_warning;
                                }else{
                                  return null;
                                }
                                },
                              decoration: InputDecoration(
                                enabled: true,
                                filled: true,
                                hintText: AppLocalizations.of(context)!.login_screen_phone,
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
                      SizedBox(height: 25),
                      Center(
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width* 0.9,
                          child: TextFormField(
                            enabled: true,
                              onSaved: (val){
                                password = val!;
                              },
                              validator: (value){
                                if(value!.isEmpty || value.length < 4) {
                                  return AppLocalizations.of(context)!.registration_screen_password_warning;
                                }else{
                                  return null;
                                }
                              },
                              obscureText: obscure,
                              decoration: InputDecoration(
                                  enabled: true,
                                  filled: true,
                                  hintText: AppLocalizations.of(context)!.login_screen_password,
                                  suffixIcon: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        obscure = !obscure;
                                      });
                                    },
                                    icon:obscure ? Icon(Icons.remove_red_eye) : Icon(Icons.security_sharp),
                                  ),
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
                      SizedBox(height: 60),
                      InkWell(
                       onTap: (){
                         onPressedLogin();
                       },
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            color: MyTheme.golden,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(AppLocalizations.of(context)!.login_screen_log_in,style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( AppLocalizations.of(context)!.you_dont_have_account,
                      style: TextStyle(
                      color: MyTheme.font_grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Regisiteration()));
                      },
                      child: Text(AppLocalizations.of(context)!.login_screen_sign_up,style: TextStyle(
                          color: MyTheme.golden,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
