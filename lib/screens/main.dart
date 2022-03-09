
import 'package:elhasnaa/data_model/country.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/screens/cart.dart';
import 'package:elhasnaa/screens/category_details.dart';
import 'package:elhasnaa/screens/home.dart';
import 'package:elhasnaa/screens/profile.dart';
import 'package:elhasnaa/screens/vendor_screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Main extends StatefulWidget {

  Main({Key? key, goBack = true})
      : super(key: key);

  bool? goBack;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;
  final _children = [
    //Home(),
    //CategoryList(
    //  is_base_category: true,
    //),
   // Scaffold(),
    Home(),
    CategoryDetais(homCatTabedInd: 0,),
    Home(),
    CartScreen(has_bottomnav: true,),            //has_bottomnav: true),
    Profile()
  ];

  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    //re appear statusbar in case it was not there in the previous page
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return widget.goBack!;
      },
      child: Directionality(
        textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          extendBody: true,
          body: _children[_currentIndex],
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          //specify the location of the FAB
          floatingActionButton: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom ==
                0.0, // if the kyeboard is open then hide, else show
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {},
              tooltip: "start FAB",
              child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  margin: const EdgeInsets.all(0.0),
                  child: IconButton(
                      icon: Image.asset('assets/1.jpg',fit: BoxFit.cover,height:double.infinity ,width: double.infinity),
                      tooltip: 'Action',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return VendorScreen();
                          //  Filter(
                          //   selected_filter: "sellers",
                          // );
                        }));
                      })),
              elevation: 0.0,
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: onTapped,
                currentIndex: _currentIndex,
                backgroundColor: Colors.white.withOpacity(0.8),
                fixedColor: Theme.of(context).accentColor,
                unselectedItemColor: const Color.fromRGBO(153, 153, 153, 1),
                items: [
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/home.png",
                        color: _currentIndex == 0
                            ? Colors.amber
                            : const Color.fromRGBO(153, 153, 153, 1),
                        height: 23,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.main_screen_bottom_navigation_home,
                          style: const TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      )),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/categories.png",
                        color: _currentIndex == 1
                            ? Colors.amber
                            : const Color.fromRGBO(153, 153, 153, 1),
                        height: 23,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.main_screen_bottom_navigation_categories,
                          style: const TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      )),
                  const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.circle,
                      color: Colors.transparent,
                    ),
                    title: Text('البائعين',style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,fontWeight: FontWeight.bold
                    ),),
                  ),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/cart.png",
                        color: _currentIndex == 3
                            ? MyTheme.golden
                            : const Color.fromRGBO(153, 153, 153, 1),
                        height: 23,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.main_screen_bottom_navigation_cart,
                          style: const TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      )),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/profile.png",
                        color: _currentIndex == 4
                            ? MyTheme.golden
                            : const Color.fromRGBO(153, 153, 153, 1),
                        height: 23,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.main_screen_bottom_navigation_profile,
                          style: const TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}