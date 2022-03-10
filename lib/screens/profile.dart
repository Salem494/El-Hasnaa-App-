import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/screens/favorite_screen.dart';
import 'package:elhasnaa/screens/my_orders.dart';
import 'package:elhasnaa/ui_elements/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Profile extends StatefulWidget {
  Profile({Key? key, this.show_back_button = false}) : super(key: key);

  bool show_back_button;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ScrollController _mainScrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _cartCounter = 0;
  String _cartCounterString = "...";
  int _wishlistCounter = 0;
  String _wishlistCounterString = "...";
  int _orderCounter = 0;
  String _orderCounterString = "...";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // if (is_logged_in.$ == true) {
    //   fetchAll();
    //   print('-------profile------');
    //   print('app lang = ${app_language.$}');
    //   print('app_mobile_language = ${app_mobile_language.$}');
    //   print('app_language_rtl = ${app_language_rtl.$}');
    //   print('is_logged_in = ${is_logged_in.$}');
    //   print('auser_name = ${user_name.$}');
    //   print('avatar_original = ${avatar_original.$}');
    // }
  }

  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }

  Future<void> _onPageRefresh() async {
    reset();
    fetchAll();
  }

  onPopped(value) async {
    reset();
    fetchAll();
  }

  fetchAll() {
    //fetchCounters();
  }

  // fetchCounters() async {
  //   var profileCountersResponse =
  //       await ProfileRepository().getProfileCountersResponse();

  //   _cartCounter = profileCountersResponse.cart_item_count;
  //   _wishlistCounter = profileCountersResponse.wishlist_item_count;
  //   _orderCounter = profileCountersResponse.order_count;

  //   _cartCounterString =
  //       counterText(_cartCounter.toString(), default_length: 2);
  //   _wishlistCounterString =
  //       counterText(_wishlistCounter.toString(), default_length: 2);
  //   _orderCounterString =
  //       counterText(_orderCounter.toString(), default_length: 2);

  //   setState(() {});
  // }

  String counterText(String txt, {default_length = 3}) {
    var blank_zeros = default_length == 3 ? "000" : "00";
    var leading_zeros = "";
    if (txt != null) {
      if (default_length == 3 && txt.length == 1) {
        leading_zeros = "00";
      } else if (default_length == 3 && txt.length == 2) {
        leading_zeros = "0";
      } else if (default_length == 2 && txt.length == 1) {
        leading_zeros = "0";
      }
    }

    var newtxt = (txt == null || txt == "" || txt == null.toString())
        ? blank_zeros
        : txt;

    // print(txt + " " + default_length.toString());
    // print(newtxt);

    if (default_length > txt.length) {
      newtxt = leading_zeros + newtxt;
    }
    //print(newtxt);

    return newtxt;
  }

  reset() {
    _cartCounter = 0;
    _cartCounterString = "...";
    _wishlistCounter = 0;
    _wishlistCounterString = "...";
    _orderCounter = 0;
    _orderCounterString = "...";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const MainDrawer(),
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: buildBody(context),
      ),
    );
  }

  buildBody(context) {
    if (is_logged_in.$ == false) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                AppLocalizations.of(context)!.profile_screen_please_log_in,
                style: TextStyle(color: MyTheme.font_grey),
              )));
    } else {
      return RefreshIndicator(
        color: MyTheme.accent_color,
        backgroundColor: Colors.white,
        onRefresh: _onPageRefresh,
        displacement: 10,
        child: CustomScrollView(
          controller: _mainScrollController,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                buildTopSection(),
                buildCountersRow(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    height: 24,
                  ),
                ),
                buildHorizontalMenu(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    height: 24,
                  ),
                ),
                // buildVerticalMenu()
              ]),
            )
          ],
        ),
      );
    }
  }

  buildHorizontalMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MyOrdersScreen();//OrderList();
            }));
          },
          child: Column(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: MyTheme.light_grey,
                    shape: BoxShape.circle,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.assignment_outlined,
                      color: Colors.green,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  AppLocalizations.of(context)!.profile_screen_orders,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyTheme.font_grey, fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            // Toast.show('welcom', context,textColor: Colors.blue );
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Scaffold();//profile edit //todo
            })).then((value) {
              onPopped(value);
            });
          },
          child: Column(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: MyTheme.light_grey,
                    shape: BoxShape.circle,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.settings,
                      color: Colors.blueAccent,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  AppLocalizations.of(context)!.profile_screen_profile,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyTheme.font_grey, fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Wishlist();
            }));
          },
          child: Column(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: MyTheme.light_grey,
                    shape: BoxShape.circle,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.red,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  AppLocalizations.of(context)!.main_drawer_my_wishlist,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyTheme.font_grey, fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  // buildVerticalMenu() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         InkWell(
  //           onTap: () {
  //             // ToastComponent.showDialog(AppLocalizations.of(context).common_coming_soon, context,
  //             //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
  //           },
  //           child: Visibility(
  //             visible: false,
  //             child: Padding(
  //               padding: const EdgeInsets.only(bottom: 16.0),
  //               child: Row(
  //                 children: [
  //                   Container(
  //                       height: 40,
  //                       width: 40,
  //                       decoration: const BoxDecoration(
  //                         color: Colors.amber,
  //                         shape: BoxShape.circle,
  //                       ),
  //                       child: const Padding(
  //                         padding: EdgeInsets.all(8.0),
  //                         child: Icon(
  //                           Icons.notifications_outlined,
  //                           color: Colors.white,
  //                         ),
  //                       )),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //                     child: Text(
  //                       AppLocalizations.of(context)!.profile_screen_notification,
  //                       textAlign: TextAlign.center,
  //                       style:
  //                           TextStyle(color: MyTheme.font_grey, fontSize: 14),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         InkWell(
  //           onTap: () {
  //             Navigator.push(context, MaterialPageRoute(builder: (context) {
  //               return OrderList();
  //             }));
  //           },
  //           child: Padding(
  //             padding: const EdgeInsets.only(bottom: 16.0),
  //             child: Row(
  //               children: [
  //                 Container(
  //                     height: 40,
  //                     width: 40,
  //                     decoration: BoxDecoration(
  //                       color: Colors.green,
  //                       shape: BoxShape.circle,
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Icon(
  //                         Icons.credit_card_rounded,
  //                         color: Colors.white,
  //                       ),
  //                     )),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //                   child: Text(
  //                     AppLocalizations.of(context).profile_screen_purchase_history,
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(color: MyTheme.font_grey, fontSize: 14),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //         AddonConfig.club_point_addon_installed
  //             ? InkWell(
  //                 onTap: () {
  //                   Navigator.push(context,
  //                       MaterialPageRoute(builder: (context) {
  //                     return Clubpoint();
  //                   }));
  //                 },
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(bottom: 16.0),
  //                   child: Row(
  //                     children: [
  //                       Container(
  //                           height: 40,
  //                           width: 40,
  //                           decoration: BoxDecoration(
  //                             color: Colors.orange,
  //                             shape: BoxShape.circle,
  //                           ),
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Icon(
  //                               Icons.monetization_on_outlined,
  //                               color: Colors.white,
  //                             ),
  //                           )),
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //                         child: Text(
  //                           AppLocalizations.of(context).profile_screen_earning_points,
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(
  //                               color: MyTheme.font_grey, fontSize: 14),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               )
  //             : Container(),
  //         AddonConfig.refund_addon_installed
  //             ? InkWell(
  //           onTap: () {
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) {
  //                   return RefundRequest();
  //                 }));
  //           },
  //           child: Padding(
  //             padding: const EdgeInsets.only(bottom: 16.0),
  //             child: Row(
  //               children: [
  //                 Container(
  //                     height: 40,
  //                     width: 40,
  //                     decoration: BoxDecoration(
  //                       color: Colors.pinkAccent,
  //                       shape: BoxShape.circle,
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Icon(
  //                         Icons.double_arrow,
  //                         color: Colors.white,
  //                       ),
  //                     )),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //                   child: Text(
  //                     AppLocalizations.of(context).profile_screen_refund_requests,
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                         color: MyTheme.font_grey, fontSize: 14),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         )
  //             : Container(),
  //       ],
  //     ),
  //   );
  // }

  buildCountersRow() {
    print('country iddd ==== ${country_id.$}');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _cartCounterString,
                style: TextStyle(
                    fontSize: 16,
                    color: MyTheme.font_grey,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  AppLocalizations.of(context)!.profile_screen_in_your_cart,
                  style: TextStyle(
                    color: MyTheme.medium_grey,
                  ),
                )),
          ],
        ),
        // Column(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.only(top: 8.0),
        //       child: Text(
        //         _wishlistCounterString,
        //         style: TextStyle(
        //             fontSize: 16,
        //             color: MyTheme.font_grey,
        //             fontWeight: FontWeight.w600),
        //       ),
        //     ),
        //     // Padding(
        //     //     padding: const EdgeInsets.only(top: 4.0),
        //     //     child: Text(
        //     //       AppLocalizations.of(context).profile_screen_in_wishlist,
        //     //       style: TextStyle(
        //     //         color: MyTheme.medium_grey,
        //     //       ),
        //     //     )),
        //   ],
        // ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _orderCounterString,
                style: TextStyle(
                    fontSize: 16,
                    color: MyTheme.font_grey,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  AppLocalizations.of(context)!.profile_screen_in_ordered,
                  style: TextStyle(
                    color: MyTheme.medium_grey,
                  ),
                )),
          ],
        )
      ],
    );
  }

  buildTopSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                  color: const Color.fromRGBO(112, 112, 112, .3), width: 2),
              //shape: BoxShape.rectangle,
            ),
            child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/1.jpg', //todo git img url from api
                  image: 'http://www.schilthuis.com/app/uploads/2015/04/Generic_Placeholder_-_Profile.jpg', //AppConfig.BASE_PATH + "${avatar_original.$}",
                  fit: BoxFit.fill,
                ),
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "${user_name.$}",
            style: TextStyle(
                fontSize: 14,
                color: MyTheme.font_grey,
                fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: user_name.$ != "" && user_name.$ != null
                ? Text(
              "${user_name.$}",
              style: TextStyle(
                color: MyTheme.medium_grey,
              ),
            )
                : Text(
              "${user_phone.$}",
              style: TextStyle(
                color: MyTheme.medium_grey,
              ),
            )),
        // Padding(
        //   padding: const EdgeInsets.only(top: 16.0),
        //   child: Container(
        //     height: 24,
        //     child: FlatButton(
        //       color: Colors.green,
        //       // 	rgb(50,205,50)
        //       shape: const RoundedRectangleBorder(
        //           borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(16.0),
        //         bottomLeft: Radius.circular(16.0),
        //         topRight: Radius.circular(16.0),
        //         bottomRight: Radius.circular(16.0),
        //       )),
        //       child: Text(
        //         AppLocalizations.of(context)!.profile_screen_check_balance,
        //         style: const TextStyle(
        //             color: Colors.white,
        //             fontSize: 11,
        //             fontWeight: FontWeight.w600),
        //       ),
        //       onPressed: () {
        //         Navigator.push(context, MaterialPageRoute(builder: (context) {
        //           return Wallet();
        //         }));
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: GestureDetector(
        child: widget.show_back_button
            ? Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
            onPressed: () => Navigator.of(context).pop(),
          ),
        )
            : Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 18.0, horizontal: 0.0),
              child: Container(
                child: Image.asset(
                  'assets/hamburger.png',
                  height: 16,
                  color: MyTheme.dark_grey,
                ),
              ),
            ),
          ),
        ),
      ),
      title: Text(
        AppLocalizations.of(context)!.profile_screen_account,
        style: TextStyle(fontSize: 16, color: MyTheme.accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}