import 'package:elhasnaa/app_config.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/screens/change_language.dart';
import 'package:elhasnaa/screens/favorite_screen.dart';
import 'package:elhasnaa/screens/main.dart';
import 'package:elhasnaa/screens/my_orders.dart';
import 'package:elhasnaa/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  // onTapLogout(context) async {
  //  //AuthHelper().clearUserData();
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return Login();
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    // print('avatar urrrrl${avatar_original.$}');
    return Drawer(
      child: Directionality(
        textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Container(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                is_logged_in.$ == true
                    ? ListTile(
                  //leading:
                  // avatar_original.$==''? CircleAvatar(
                  //   backgroundColor: Colors.blue,

                  // ):CircleAvatar(

                  //   backgroundImage: NetworkImage(
                  //     AppConfig.BASE_PATH + "${avatar_original.$}",

                  //   ),
                  // ),
                    title: Text(user_name.$),
                    subtitle:
                    user_name.$ != "" && user_name.$ != null
                        ? Text(user_name.$)
                        : Text(user_phone.$))
                    : Text(AppLocalizations.of(context)!.main_drawer_not_logged_in,
                    style: const TextStyle(
                        color: Color.fromRGBO(153, 153, 153, 1),
                        fontSize: 14)),
                const Divider(),
                ListTile(
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/language.png",
                        height: 16, color: const Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context)!.main_drawer_change_language,
                        style: const TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return ChangeLanguage();
                          }));
                    }),
                ListTile(
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/home.png",
                        height: 16, color: const Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context)!.main_drawer_home,
                        style: const TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Main();
                          }));
                    }),
                is_logged_in.$ == true
                    ? ListTile(
                    visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/profile.png",
                        height: 16, color: const Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context)!.main_drawer_profile,
                        style: const TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return  Profile(); //Profile(show_back_button: true);
                          }));
                    })
                    : Container(),
                is_logged_in.$ == true
                    ? ListTile(
                    visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/order.png",
                        height: 16, color: const Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context)!.main_drawer_orders,
                        style: const TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return  MyOrdersScreen(); //OrderList(from_checkout: false);
                          }));
                    })
                    : Container(),
                is_logged_in.$ == true
                    ? ListTile(
                    visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/heart.png",
                        height: 16, color: const Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context)!.main_drawer_my_wishlist,
                        style: const TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return  Wishlist();//Wishlist();
                          }));
                    })
                    : Container(),
                const Divider(height: 24),
                is_logged_in.$ == false
                    ? ListTile(
                    visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/login.png",
                        height: 16, color: const Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context)!.main_drawer_login,
                        style: const TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Scaffold();//Login();
                          }));
                    })
                    : Container(),
                is_logged_in.$ == true
                    ? ListTile(
                    visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/logout.png",
                        height: 16, color: const Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context)!.main_drawer_logout,
                        style: const TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Scaffold(); //onTapLogout(context);
                    })
                    : Container(),
                // Container(
                //   width: 100,
                //   height: 50,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}