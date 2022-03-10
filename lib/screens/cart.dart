import 'package:elhasnaa/data_model/cart_model.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/helpers/shimmer_helper.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/repositories/add_cart_repo.dart';
import 'package:elhasnaa/screens/profile.dart';
import 'package:elhasnaa/ui_elements/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, required this.has_bottomnav}) : super(key: key);
  final bool has_bottomnav;

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _mainScrollController = ScrollController();
  List<CartModel> _shopList = [];
  bool _isInitial = true;
  var _cartTotal = 0.00;
  var _cartTotalString = ". . .";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /*print("user data");
    print(is_logged_in.$);
    print(access_token.value);
    print(user_id.$);
    print(user_name.$);*/

    if (is_logged_in.$ == true) {
      fetchData();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _mainScrollController.dispose();
  }

  fetchData() async {

    var cartResponseList =
    await CartRepo().fetchCartUser();

    if (cartResponseList != null && cartResponseList.isNotEmpty) {
      _shopList = cartResponseList;
    }
    _isInitial = false;
    getSetCartTotal();
    setState(() {});
  }

  getSetCartTotal() {
    _cartTotal = 0.00;
    if (_shopList.isNotEmpty) {
      _shopList.forEach((shop) {
        _cartTotal +=double.parse(shop.total!)*int.parse(shop.prodNo!);
        _cartTotalString="$_cartTotal"+shop.coinId!; //todo coin symbol

      });
    }

    setState(() {});
  }

  partialTotalString(index) {
    var partialTotal = 0.00;
    var partialTotalString = "";
    if (_shopList[index].total!.isNotEmpty) {
      partialTotal += double.parse(_shopList[index].prodPrice!) * int.parse(_shopList[index].prodNo!);
      partialTotalString = "${_shopList[index].coinId}${partialTotal}";
    }

    return partialTotalString;
  }

  onQuantityIncrease(sellerIndex) {
    int temp=(int.parse(_shopList[sellerIndex].prodNo!))+1;
    // print( _shopList[sellerIndex].prodNo!.replaceAll(RegExp(r'\d+'), '$temp'));
    _shopList[sellerIndex].prodNo ='$temp';
    getSetCartTotal();
    //print('jjjjbjo = ${_shopList[sellerIndex].prodNo}');
    setState(() {});
    //print('yyyiuhi${_shopList[sellerIndex].prodNo}');
  }

  onQuantityDecrease(sellerIndex) {
    int temp=int.parse(_shopList[sellerIndex].prodNo!);
    if(temp>1){
      temp--;
    }
    _shopList[sellerIndex].prodNo="$temp";
    getSetCartTotal();
    setState(() {});

  }

  onPressDelete(cartId) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding: const EdgeInsets.only(
              top: 16.0, left: 2.0, right: 2.0, bottom: 2.0),
          content: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              AppLocalizations.of(context)!.cart_screen_sure_remove_item,
              maxLines: 3,
              style: TextStyle(color: MyTheme.font_grey, fontSize: 14),
            ),
          ),
          actions: [
            FlatButton(
              child: Text(
                AppLocalizations.of(context)!.cart_screen_cancel,
                style: TextStyle(color: MyTheme.medium_grey),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            FlatButton(
              color: MyTheme.soft_accent_color,
              child: Text(
                AppLocalizations.of(context)!.cart_screen_confirm,
                style: TextStyle(color: MyTheme.dark_grey),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                confirmDelete(cartId);
              },
            ),
          ],
        ));
  }

  confirmDelete(prodId) async {
    var cartDeleteResponse =
    await CartRepo().getCartDeleteResponse(prodId);
    if (cartDeleteResponse=="Success") {
      // ToastComponent.showDialog(cartDeleteResponse.message, context,
      //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      print(cartDeleteResponse);

      reset();
      fetchData();
    } else {
      // ToastComponent.showDialog(cartDeleteResponse.message, context,
      //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      print(cartDeleteResponse);
    }
  }

  onPressUpdate() {
    //process(mode: "update");
  }

  onPressProceedToShipping() {
    process(mode: "proceed_to_shipping");
  }

  process({mode}) async {
    double totalPrice =_cartTotal;
    print('totallllllllllllllllprice  ${totalPrice}');
   // var cartQuantities = [];
    // if (_shopList.length > 0) {
    //   _shopList.forEach((shop) {
    //     totalPrice+=double.parse(shop.total!);
    //   });
    // }

    // if (cartIds.length == 0) {
    //   // ToastComponent.showDialog(AppLocalizations.of(context).cart_screen_cart_empty, context,
    //   //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    //   print(AppLocalizations.of(context)!.cart_screen_cart_empty);
    //   return;
    // }

    // var cartIdsString = cartIds.join(',').toString();
    // var cartQuantitiesString = cartQuantities.join(',').toString();

    // print(cartIdsString);
    // print(cartQuantitiesString);

    var cartProcessResponse = await CartRepo().buyCart(totalPrice: totalPrice,notes: 'notes');

    if (cartProcessResponse==false) {
      // ToastComponent.showDialog(cartProcessResponse.message, context,
      //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      print(cartProcessResponse);
    } else {
      // ToastComponent.showDialog(cartProcessResponse.message, context,
      //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      print("sucessss");


      // if (mode == "update") {
      //   reset();
      //   fetchData();
      // } else
      if (mode == "proceed_to_shipping") {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Profile(

          );
        })).then((value) {
          onPopped(value);
        });
      }
    }
  }

  reset() {
    _shopList = [];
    _isInitial = true;
    _cartTotal = 0.00;
    _cartTotalString = ". . .";

    setState(() {});
  }

  Future<void> _onRefresh() async {
    reset();
    fetchData();
  }

  onPopped(value) async {
    reset();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.has_bottomnav);
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          key: _scaffoldKey,
          drawer: const MainDrawer(),
          backgroundColor: Colors.white,
          appBar: buildAppBar(context),
          body: Stack(
            children: [
              RefreshIndicator(
                color: MyTheme.accent_color,
                backgroundColor: Colors.white,
                onRefresh: _onRefresh,
                displacement: 0,
                child: CustomScrollView(
                  controller: _mainScrollController,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: buildCartSellerList(),
                        ),
                        Container(
                          height: widget.has_bottomnav ? 140 : 100,
                        )
                      ]),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: buildBottomContainer(),
              )
            ],
          )),
    );
  }

  Container buildBottomContainer() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        /*border: Border(
                  top: BorderSide(color: MyTheme.light_grey,width: 1.0),
                )*/
      ),

      height: widget.has_bottomnav ? 200 : 120,
      //color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 40,
              width: (MediaQuery.of(context).size.width ) * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: MyTheme.soft_accent_color),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        AppLocalizations.of(context)!.cart_screen_total_amount,
                        style:
                        TextStyle(color: MyTheme.font_grey, fontSize: 14),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("$_cartTotalString",
                          style: TextStyle(
                              color: MyTheme.accent_color,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                              ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0),
                //   child: Container(
                //     width: (MediaQuery.of(context).size.width - 32) * (1 / 3),
                //     height: 38,
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         border:
                //         Border.all(color: MyTheme.textfield_grey, width: 1),
                //         borderRadius: app_language_rtl.$ ?
                //         const BorderRadius.only(
                //           topLeft: Radius.circular(0.0),
                //           bottomLeft: Radius.circular(0.0),
                //           topRight: Radius.circular(8.0),
                //           bottomRight: Radius.circular(8.0),
                //         ): const BorderRadius.only(
                //           topLeft: Radius.circular(8.0),
                //           bottomLeft: Radius.circular(8.0),
                //           topRight: Radius.circular(0.0),
                //           bottomRight: Radius.circular(0.0),
                //         )),
                //     child: FlatButton(
                //       minWidth: MediaQuery.of(context).size.width,
                //       //height: 50,
                //       color: MyTheme.light_grey,
                //       shape: app_language_rtl.$?
                //       const RoundedRectangleBorder(
                //           borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(0.0),
                //             bottomLeft: Radius.circular(0.0),
                //             topRight: Radius.circular(8.0),
                //             bottomRight: Radius.circular(8.0),
                //           ))
                //           : const RoundedRectangleBorder(
                //           borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(8.0),
                //             bottomLeft: Radius.circular(8.0),
                //             topRight: Radius.circular(0.0),
                //             bottomRight: Radius.circular(0.0),
                //           )),
                //       child: Text(
                //         AppLocalizations.of(context)!.cart_screen_update_cart,
                //         style: TextStyle(
                //             color: MyTheme.medium_grey,
                //             fontSize: 13,
                //             fontWeight: FontWeight.w600),
                //       ),
                //       onPressed: () {
                //         onPressUpdate();
                //       },
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width:(MediaQuery.of(context).size.width ) * 0.9,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                        Border.all(color: MyTheme.textfield_grey, width: 1),
                        borderRadius:app_language_rtl.$ ?
                        const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                        ): const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                        )),
                    child: FlatButton(
                      minWidth: MediaQuery.of(context).size.width,
                      //height: 50,
                      color: MyTheme.accent_color,
                      shape: app_language_rtl.$ ?
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ))
                          : const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          )),
                      child: Text(
                        AppLocalizations.of(context)!.cart_screen_proceed_to_shipping,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        onPressProceedToShipping();
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        child: Builder(
          builder: (context) => Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 18.0, horizontal: 0.0),
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
      title: Text(
        AppLocalizations.of(context)!.cart_screen_shopping_cart,
        style: TextStyle(fontSize: 16, color: MyTheme.accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }



  buildCartSellerList() {
    if (is_logged_in.$ == false) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                AppLocalizations.of(context)!.cart_screen_please_log_in,
                style: TextStyle(color: MyTheme.font_grey),
              )));
    } else if (_isInitial && _shopList.isEmpty) {
      return SingleChildScrollView(
          child: ShimmerHelper()
              .buildListShimmer(item_count: 5, item_height: 100.0));
    } else if (_shopList.isNotEmpty) {
      return SingleChildScrollView(
        child: ListView.builder(
          itemCount: _shopList.length,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0.0, top: 16.0),
                    child: Row(
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: Text(
                            localizeBrandName(_shopList[index]),//todo localization
                            style: TextStyle(color: MyTheme.font_grey),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            partialTotalString(index),
                            style: TextStyle(
                                color: MyTheme.accent_color, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildCartSellerItemList(index),
                ],
              ),
            );
          },
        ),
      );
    } else if (!_isInitial && _shopList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                AppLocalizations.of(context)!.cart_screen_cart_empty,
                style: TextStyle(color: MyTheme.font_grey),
              )));
    }
  }

  SingleChildScrollView buildCartSellerItemList(sellerIndex) {
    return SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: buildCartSellerItemCard(sellerIndex),
        )
    );
  }

  buildCartSellerItemCard(sellerIndex) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: MyTheme.light_grey, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
            width: 90,
            height: 90,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder.png',
                  image: 'https://alhasnaa.site/files/' +
                      _shopList[sellerIndex].prodImg!,
                  fit: BoxFit.fitWidth,
                ))),
        Container(
          width: 170,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizeName(_shopList[sellerIndex]),//todo loca
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: MyTheme.font_grey,
                          fontSize: 14,
                          height: 1.6,
                          fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            (double.parse(_shopList[sellerIndex].prodPrice!).toString()),
                            //     *int.parse(_shopList[sellerIndex].prodNo!))
                            // .toString(),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: MyTheme.accent_color,
                                fontSize: 14,
                                height: 1.6,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          height: 28,
                          child: InkWell(
                            onTap: () {},
                            child: IconButton(
                              onPressed: () {
                                onPressDelete(_shopList[sellerIndex].prodId);

                                //todo
                              },
                              icon: Icon(
                                Icons.delete_forever_outlined,
                                color: MyTheme.medium_grey,
                                size: 24,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: 28,
                height: 28,
                child: FlatButton(
                  padding: const EdgeInsets.all(0),
                  child: Icon(
                    Icons.add,
                    color: MyTheme.accent_color,
                    size: 18,
                  ),
                  shape: CircleBorder(
                    side: BorderSide(color: MyTheme.light_grey, width: 1.0),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    onQuantityIncrease(sellerIndex);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  _shopList[sellerIndex].prodNo!
                  ,
                  style: TextStyle(color: MyTheme.accent_color, fontSize: 16),
                ),
              ),
              SizedBox(
                width: 28,
                height: 28,
                child: FlatButton(
                  padding: const EdgeInsets.all(0),
                  child: Icon(
                    Icons.remove,
                    color: MyTheme.accent_color,
                    size: 18,
                  ),
                  height: 30,
                  shape: CircleBorder(
                    side: BorderSide(color: MyTheme.light_grey, width: 1.0),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    onQuantityDecrease(sellerIndex);
                  },
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  String localizeName(CartModel prod) {
    if (app_mobile_language.$ == 'en') {
      return prod.prodNameEn!;
    } else if (app_language.$ == 'ar') {
      return prod.prodNameAr!;
    } else {
      return prod.prodNameTr!;
    }
  }
 
  String localizeBrandName(CartModel prod) {
    if (app_mobile_language.$ == 'en') {
      return prod.brandNameEn!;
    } else if (app_language.$ == 'ar') {
      return prod.brandNameAr!;
    } else {
      return prod.brandNameTr!;
    }
  }


}