import 'package:elhasnaa/custom/input_decorations.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/screens/main.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Directionality(
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
                        onPressLogin();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: MyTheme.golden,
                        ),
                        height: 50,
                        child: Center(
                          child: Text(
                            'Login',
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
                        child: Center(
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
  onPressLogin(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Main()),
      );
  }
}