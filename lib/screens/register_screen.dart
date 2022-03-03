import 'package:elhasnaa/custom/input_decorations.dart';
import 'package:elhasnaa/data_model/country.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/provider/locale_provider.dart';
import 'package:elhasnaa/repositories/getCountryCat.dart';
import 'package:elhasnaa/screens/login_screen.dart';
import 'package:elhasnaa/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Country? valueChoose;
  List<Country> countryList = [];
  final formkey = GlobalKey<FormState>();

  getCountryList() async {
    List<Country> countryResponse = await CountryRepo().fetchCountryCat();
    countryList.addAll(countryResponse);
    setState(() {});
  }

  // fetchData() {
  //   getCountryList();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountryList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Creat Account / Login',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      child: TextFormField(
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return ;
                        //   } else
                        //     return null;
                        // },
                        controller: _nameController,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "Your Complete Name"),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    countryList.isNotEmpty
                        ? Container(
                            height: 50,
                            width: double.infinity,
                            child: DropdownButtonFormField(
                              decoration:
                                  InputDecorations.buildInputDecoration_1(
                                      hint_text: "Your Country"),
                              // hint: Text('Your Country'),
                              autofocus: false,
                              value: valueChoose,
                              onChanged: (newVal) {
                                setState(() {
                                  valueChoose = newVal as Country?;
                                });
                              },
                              items: countryList.map((country) {
                                return DropdownMenuItem(
                                  value: country,
                                  child: Row(
                                    children: [
                                      FadeInImage.assetNetwork(
                                        placeholder:
                                            'assets/1.jpg', //todo git img url from api
                                        image: 'https://alhasnaa.site/files/' +
                                            country.flag!,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('${country.countryNameEn}'),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        : CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      child: TextFormField(
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return ;
                        //   } else
                        //     return null;
                        // },
                        controller: _phoneNumberController,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "Phone Number"),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      child: TextFormField(
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return ;
                        //   } else
                        //     return null;
                        // },
                        controller: _emailController,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "Email"),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      child: TextFormField(
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return ;
                        //   } else
                        //     return null;
                        // },
                        controller: _passwordController,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "Password"),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        onPressSignUp();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: MyTheme.golden,
                        ),
                        height: 50,
                        child: Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 1,
                            color: Colors.grey),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'OR',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 1,
                            color: Colors.grey),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.blue,
                        ),
                        height: 50,
                        child: Center( //google_logo.png
                          child: 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text(
                            'Register By Google',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          SizedBox(width: 20,),
                          SizedBox(
                            height: 25,
                            width: 25,
                            child:  Image.asset(
                            'assets/google_logo.png',
                            fit: BoxFit.cover,
                             
                          ),
                          ),
                      
                            ],
                          ),
                         
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onPressSignUp() async {
    String name = _nameController.text.toString();
    String email = _emailController.text.toString();
    String phone = _phoneNumberController.text.toString();
    String passw = _passwordController.text.toString();
    Country? valChoose= valueChoose;


    if (name.isNotEmpty && email.isNotEmpty && phone.isNotEmpty && passw.isNotEmpty && valChoose!.id!.isNotEmpty) {
      country_id.$ = valueChoose!.id!;
      country_id.save();
      app_language.$ = valueChoose!.catNameAr!;
      app_language.save();
      app_mobile_language.$ = valueChoose!.lang!;
      app_mobile_language.save();
      if (valueChoose!.lang == 'ar') {
        app_language_rtl.$ = true;
        app_language_rtl.save();
      } else {
        app_language_rtl.$ = false;
        app_language_rtl.save();
      }

      Provider.of<LocaleProvider>(context, listen: false)
          .setLocale(valueChoose!.lang!);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }else{
      Scaffold.of(context).showSnackBar(const SnackBar(
            elevation: 5,
            duration: Duration(seconds: 3),
            content: Text('There is Empty Field'),
          ));
    }
  }
}
