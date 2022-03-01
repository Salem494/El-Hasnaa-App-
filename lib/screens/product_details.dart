import 'package:elhasnaa/app_config.dart';
import 'package:elhasnaa/data_model/fav_model.dart';
import 'package:elhasnaa/data_model/products.dart';
import 'package:elhasnaa/data_model/related_product.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/helpers/shimmer_helper.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/repositories/add_cart_repo.dart';
import 'package:elhasnaa/repositories/add_fav_repo.dart';
import 'package:elhasnaa/repositories/products_response.dart';
import 'package:elhasnaa/screens/cart.dart';
import 'package:elhasnaa/screens/main.dart';
import 'package:elhasnaa/ui_elements/mini_product_card.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:expandable/expandable.dart';
import 'dart:ui';
import 'package:flutter_html/flutter_html.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';

class ProductDetails extends StatefulWidget {
  Products product;

  ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _showCopied = false;
  //String _appbarPriceString = ". . .";
  int _currentImage = 0;
  ScrollController _mainScrollController = ScrollController();
  ScrollController _colorScrollController = ScrollController();
  ScrollController _variantScrollController = ScrollController();
  ScrollController _imageScrollController = ScrollController();
  TextEditingController sellerChatTitleController = TextEditingController();
  TextEditingController sellerChatMessageController = TextEditingController();

  //init values
  bool _isInWishList = false;
  var _productDetailsFetched = false;
  //var _productDetails = null;
  var _productImageList = [];
  final List<Color> _colorList = const [ Color.fromRGBO(14, 15, 15,1),Color.fromRGBO(247, 5, 25,1),Color.fromRGBO(247, 243, 5,1)];
  int _selectedColorIndex = 0;
  var _selectedChoices = [];
  var _choiceString = "";
  var _variant = "";
  var _totalPrice;
  var _singlePrice;
  //var _singlePriceString;
  int _quantity = 1;
  int _stock = 0;
  List<FavModel> _wishlistItems=[];

  List<RelatedProducts> _relatedProducts = [];
  bool _relatedProductInit = false;
  List<dynamic> _topProducts = [];
  bool _topProductInit = false;

  @override
  void initState() {
    fetchAll();
    super.initState();
  }

  @override
  void dispose() {
    _mainScrollController.dispose();
    _variantScrollController.dispose();
    _imageScrollController.dispose();
    _colorScrollController.dispose();
    super.dispose();
  }

  fetchAll() async{
    // print("product id : ${widget.id}");
    // fetchProductDetails();
    if (is_logged_in.$ == true) {

      await fetchWishlistItems();
      fetchWishListCheckInfo();
    }
    setProductDetailValues();
    fetchRelatedProducts();
    // fetchTopProducts();
  }

  // fetchProductDetails() async {
  //   var productDetailsResponse =
  //       await ProductsResponse().fetchCountrySubCP(widget.id, 1);

  //   if (productDetailsResponse!.detailed_products.length > 0) {
  //     _productDetails = productDetailsResponse.detailed_products[0];
  //     sellerChatTitleController.text =
  //         productDetailsResponse.detailed_products[0].name;
  //   }

  //setProductDetailValues();

  //   setState(() {});
  // }

  fetchRelatedProducts() async {
    var relatedProductResponse =
    await ProductsResponse().fetchRelatedProd(widget.product.id!,"1");//todo country id
    _relatedProducts.addAll(relatedProductResponse);
    _relatedProductInit = true;

    setState(() {});
  }

  // fetchTopProducts() async {
  //   var topProductResponse =
  //       await ProductRepository().getTopFromThisSellerProducts(id: widget.id);
  //   _topProducts.addAll(topProductResponse.products);
  //   _topProductInit = true;
  // }

  setProductDetailValues() {
    if (widget.product.id != null) {
      // _appbarPriceString = _productDetails.price_high_low;
      print('singgggle price ---- ${widget.product.prodPrice}');
      _singlePrice =double.parse(widget.product.prodPrice!);//_productDetails.calculable_price;
      // _singlePriceString = widget.product.prodPriceOld;//_productDetails.main_price;
      calculateTotalPrice();
      _stock =int.parse(widget.product.prodNo!);
      //_productDetails.current_stock;
      if(widget.product.images!.isNotEmpty)
      {
        widget.product.images!.forEach((photo) {
          _productImageList.add('https://alhasnaa.site/files/$photo');
        });
        print(_productImageList);
      }

      // _productDetails.choice_options.forEach((choice_opiton) {
      //   _selectedChoices.add(choice_opiton.options[0]);
      // });
      // _productDetails.colors.forEach((color) {
      //   _colorList.add(color);
      // });

      // setChoiceString();

      // if (_productDetails.colors.length > 0 ||
      //     _productDetails.choice_options.length > 0) {
      //   fetchAndSetVariantWiseInfo(change_appbar_string: true);
      // }
      _productDetailsFetched = true;

      setState(() {});
    }
  }

  fetchWishlistItems() async {
    var wishlistResponse = await Favorites().getWishList(user_id.$);
    _wishlistItems.addAll(wishlistResponse);
    //_wishlistInit = false;
    setState(() {});
  }

  // setChoiceString() {
  //   _choiceString = _selectedChoices.join(",").toString();
  //   //print(_choiceString);
  //   setState(() {});
  // }

  fetchWishListCheckInfo()  {
    // var wishListCheckResponse =
    //     await WishListRepository().isProductInUserWishList(
    //   product_id: widget.id,
    // );
    print('888888888888888888 $_wishlistItems');
    //print("p&u:" + widget.id.toString() + " | " + _user_id.toString());
    //_isInWishList = wishListCheckResponse.is_in_wishlist;
    _wishlistItems.forEach((element){
      print("${element.id}=? ${widget.product.id!}");
      if(element.id==widget.product.id!){
        print("its in wish lisssst");
        setState(() { _isInWishList=true;});

      }
    });

  }

  addToWishList() async {
    Future<String> wishListCheckResponse =Favorites().addFavourite(widget.product.id!);

    // await WishListRepository().add(product_id: widget.id);

    //print("p&u:" + widget.id.toString() + " | " + _user_id.toString());
    wishListCheckResponse.then((value){
      if(value.compareTo("Error")==0)
      {
        _isInWishList = true;
      }else{
        _isInWishList=false;
      }
    });

    setState(() {});
  }

  // removeFromWishList() async {
  //    var  wishListCheckResponse =
  //       await Favorites().removeFavourite(widget.product.id!);

  //   //print("p&u:" + widget.id.toString() + " | " + _user_id.toString());
  //   //_isInWishList = wishListCheckResponse.is_in_wishlist;

  //     wishListCheckResponse.then((value){
  //     if(value.compareTo("Error")==0)
  //     {
  //       _isInWishList = true;
  //     }else{
  //     _isInWishList=false;
  //   }
  //   });
  //   setState(() {});
  // }

  onWishTap() {
    if (is_logged_in.$ == false) {
      print('You must login'); //todo show snack bar
      // ToastComponent.showDialog(AppLocalizations.of(context).common_login_warning, context,
      //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }

    if (_isInWishList) {

      setState(() {

      });
      // removeFromWishList();
    } else {

      setState(() {
        _isInWishList = true;
      });
      addToWishList();
    }
  }

  // fetchAndSetVariantWiseInfo({bool change_appbar_string = true}) async {
  //   var color_string = _colorList.length > 0
  //       ? _colorList[_selectedColorIndex].toString().replaceAll("#", "")
  //       : "";

  //   /*print("color string: "+color_string);
  //   return;*/

  //   var variantResponse = await ProductRepository().getVariantWiseInfo(
  //       id: widget.id, color: color_string, variants: _choiceString);

  //   /*print("vr"+variantResponse.toJson().toString());
  //   return;*/

  //   _singlePrice = variantResponse.price;
  //   _stock = variantResponse.stock;
  //   if (_quantity > _stock) {
  //     _quantity = _stock;
  //     setState(() {});
  //   }

  //   _variant = variantResponse.variant;
  //   setState(() {});

  //   calculateTotalPrice();
  //   _singlePriceString = variantResponse.price_string;

  // if (change_appbar_string) {
  //   _appbarPriceString = "${variantResponse.variant} ${_singlePriceString}";
  // }

  //   int pindex = 0;
  //   _productDetails.photos.forEach((photo) {
  //     if (photo.variant == _variant && variantResponse.image != "") {
  //       _currentImage = pindex;
  //     }

  //     pindex++;
  //   });

  //   setState(() {});
  // }

  reset() {
    restProductDetailValues();
    _productImageList.clear();
    // _colorList.clear();
    _selectedChoices.clear();
    _relatedProducts.clear();
    _topProducts.clear();
    _choiceString = "";
    _variant = "";
    _selectedColorIndex = 0;
    _quantity = 1;
    _productDetailsFetched = false;
    _isInWishList = false;
    sellerChatTitleController.clear();
    setState(() {});
  }

  restProductDetailValues() {
    //_appbarPriceString = " . . .";
    // _productDetails = null;
    _productImageList.clear();
    _currentImage = 0;
    setState(() {});
  }

  Future<void> _onPageRefresh() async {
    // reset();
    fetchAll();
  }

  calculateTotalPrice() {
    print('calculattttttttttttttte total price $_singlePrice ,,,, quant $_quantity');
    _totalPrice = _singlePrice * _quantity;
    setState(() {});
  }

  // _onVariantChange(_choice_options_index, value) {
  //   _selectedChoices[_choice_options_index] = value;
  //   //setChoiceString();
  //   setState(() {});
  //  // fetchAndSetVariantWiseInfo();
  // }

  _onColorChange(index) {
    _selectedColorIndex = index;
    setState(() {});
    // fetchAndSetVariantWiseInfo();
  }

  onPressAddToCart(context, snackbar) {
    //print('is log in ???==== ${is_logged_in.$}');
    addToCart(mode: "add_to_cart", context: context, snackbar: snackbar);
  }

  onPressBuyNow(context) {
    addToCart(mode: "buy_now", context: context);
  }

  addToCart({mode, context = null, snackbar = null}) async {
    if (is_logged_in.$ == false) {
      print('shoulddd log in to can add to card');
      // ToastComponent.showDialog(AppLocalizations.of(context).common_login_warning, context,
      //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return ;
    }
    // print('is log in ==== ${is_logged_in.$}');
    // print(widget.id);
    // print(_variant);
    // print(user_id.$);
    // print(_quantity);

    var cartAddResponse =  CartRepo().addCart(productsId:widget.product.id! ,quant: _quantity,colr:ColorToHex(_colorList[_selectedColorIndex]),size:42);
    // Responseawait CartRepository()
    //     .getCartAddResponse(widget.id, _variant, user_id.$, _quantity);

    if (cartAddResponse == "400") {
      // ToastComponent.showDialog(cartAddResponse.message, context,
      //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    } else {
      if (mode == "add_to_cart") {
        if (snackbar != null && context != null) {
          Scaffold.of(context).showSnackBar(const SnackBar(
            elevation: 5,
            duration: Duration(seconds: 3),
            content: Text('Successfully added to cart'),
          ));
        }
        reset();
        fetchAll();
      } else if (mode == 'buy_now') {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const Scaffold();//Cart(has_bottomnav: false);
        })).then((value) {
          onPopped(value);
        });
      }
    }
  }

  onPopped(value) async {
    reset();
    fetchAll();
  }

  // onCopyTap(setState) {
  //   setState(() {
  //     _showCopied = true;
  //   });
  //   Timer timer = Timer(Duration(seconds: 3), () {
  //     setState(() {
  //       _showCopied = false;
  //     });
  //   });
  // }

  // onPressShare(context) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return StatefulBuilder(builder: (context, StateSetter setState) {
  //           return AlertDialog(
  //             insetPadding: EdgeInsets.symmetric(horizontal: 10),
  //             contentPadding: EdgeInsets.only(
  //                 top: 36.0, left: 36.0, right: 36.0, bottom: 2.0),
  //             content: Container(
  //               width: 400,
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.only(bottom: 8.0),
  //                       child: FlatButton(
  //                         minWidth: 75,
  //                         height: 26,
  //                         color: Color.fromRGBO(253, 253, 253, 1),
  //                         shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(8.0),
  //                             side:
  //                                 BorderSide(color: Colors.black, width: 1.0)),
  //                         child: Text(
  //                           AppLocalizations.of(context)!.product_details_screen_copy_product_link,
  //                           style: TextStyle(
  //                             color: MyTheme.medium_grey,
  //                           ),
  //                         ),
  //                         onPressed: () {
  //                           onCopyTap(setState);
  //                           SocialShare.copyToClipboard(_productDetails.link);
  //                         },
  //                       ),
  //                     ),
  //                     _showCopied
  //                         ? Padding(
  //                             padding: const EdgeInsets.only(bottom: 8.0),
  //                             child: Text(
  //                               AppLocalizations.of(context).common_copied,
  //                               style: TextStyle(
  //                                   color: MyTheme.medium_grey, fontSize: 12),
  //                             ),
  //                           )
  //                         : Container(),
  //                     Padding(
  //                       padding: const EdgeInsets.only(bottom: 8.0),
  //                       child: FlatButton(
  //                         minWidth: 75,
  //                         height: 26,
  //                         color: Colors.blue,
  //                         shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(8.0),
  //                             side:
  //                                 BorderSide(color: Colors.black, width: 1.0)),
  //                         child: Text(
  //                           AppLocalizations.of(context).product_details_screen_share_options,
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                         onPressed: () {
  //                           SocialShare.shareOptions(_productDetails.link);
  //                         },
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             actions: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   Padding(
  //                     padding: app_language_rtl.$ ? EdgeInsets.only(left: 8.0) : EdgeInsets.only(right: 8.0),
  //                     child: FlatButton(
  //                       minWidth: 75,
  //                       height: 30,
  //                       color: Color.fromRGBO(253, 253, 253, 1),
  //                       shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(8.0),
  //                           side: BorderSide(
  //                               color: MyTheme.font_grey, width: 1.0)),
  //                       child: Text(
  //                         "CLOSE",
  //                         style: TextStyle(
  //                           color: MyTheme.font_grey,
  //                         ),
  //                       ),
  //                       onPressed: () {
  //                         Navigator.of(context, rootNavigator: true).pop();
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           );
  //         });
  //       });
  // }

  // onTapSellerChat() {
  //   return showDialog(
  //       context: context,
  //       builder: (_) => Directionality(
  //             textDirection:
  //                 app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
  //             child: AlertDialog(
  //               insetPadding: EdgeInsets.symmetric(horizontal: 10),
  //               contentPadding: EdgeInsets.only(
  //                   top: 36.0, left: 36.0, right: 36.0, bottom: 2.0),
  //               content: Container(
  //                 width: 400,
  //                 child: SingleChildScrollView(
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.only(bottom: 8.0),
  //                         child: Text(AppLocalizations.of(context).product_details_screen_seller_chat_title,
  //                             style: TextStyle(
  //                                 color: MyTheme.font_grey, fontSize: 12)),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(bottom: 16.0),
  //                         child: Container(
  //                           height: 40,
  //                           child: TextField(
  //                             controller: sellerChatTitleController,
  //                             autofocus: false,
  //                             decoration: InputDecoration(
  //                                 hintText: AppLocalizations.of(context).product_details_screen_seller_chat_enter_title,
  //                                 hintStyle: TextStyle(
  //                                     fontSize: 12.0,
  //                                     color: MyTheme.textfield_grey),
  //                                 enabledBorder: OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: MyTheme.textfield_grey,
  //                                       width: 0.5),
  //                                   borderRadius: const BorderRadius.all(
  //                                     const Radius.circular(8.0),
  //                                   ),
  //                                 ),
  //                                 focusedBorder: OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: MyTheme.textfield_grey,
  //                                       width: 1.0),
  //                                   borderRadius: const BorderRadius.all(
  //                                     const Radius.circular(8.0),
  //                                   ),
  //                                 ),
  //                                 contentPadding:
  //                                     EdgeInsets.symmetric(horizontal: 8.0)),
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(bottom: 8.0),
  //                         child: Text("${AppLocalizations.of(context).product_details_screen_seller_chat_messasge} *",
  //                             style: TextStyle(
  //                                 color: MyTheme.font_grey, fontSize: 12)),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(bottom: 16.0),
  //                         child: Container(
  //                           height: 55,
  //                           child: TextField(
  //                             controller: sellerChatMessageController,
  //                             autofocus: false,
  //                             maxLines: null,
  //                             keyboardType: TextInputType.multiline,
  //                             decoration: InputDecoration(
  //                                 hintText: AppLocalizations.of(context).product_details_screen_seller_chat_enter_messasge,
  //                                 hintStyle: TextStyle(
  //                                     fontSize: 12.0,
  //                                     color: MyTheme.textfield_grey),
  //                                 enabledBorder: OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: MyTheme.textfield_grey,
  //                                       width: 0.5),
  //                                   borderRadius: const BorderRadius.all(
  //                                     const Radius.circular(8.0),
  //                                   ),
  //                                 ),
  //                                 focusedBorder: OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: MyTheme.textfield_grey,
  //                                       width: 1.0),
  //                                   borderRadius: const BorderRadius.all(
  //                                     const Radius.circular(8.0),
  //                                   ),
  //                                 ),
  //                                 contentPadding: EdgeInsets.only(
  //                                     right: 16.0,
  //                                     left: 8.0,
  //                                     top: 16.0,
  //                                     bottom: 16.0)),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               actions: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                       child: FlatButton(
  //                         minWidth: 75,
  //                         height: 30,
  //                         color: Color.fromRGBO(253, 253, 253, 1),
  //                         shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(8.0),
  //                             side: BorderSide(
  //                                 color: MyTheme.light_grey, width: 1.0)),
  //                         child: Text(
  //                           AppLocalizations.of(context).common_close_in_all_capital,
  //                           style: TextStyle(
  //                             color: MyTheme.font_grey,
  //                           ),
  //                         ),
  //                         onPressed: () {
  //                           Navigator.of(context, rootNavigator: true).pop();
  //                         },
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       width: 1,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 28.0),
  //                       child: FlatButton(
  //                         minWidth: 75,
  //                         height: 30,
  //                         color: MyTheme.accent_color,
  //                         shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(8.0),
  //                             side: BorderSide(
  //                                 color: MyTheme.light_grey, width: 1.0)),
  //                         child: Text(
  //                           AppLocalizations.of(context).common_send_in_all_capital,
  //                           style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.w600),
  //                         ),
  //                         onPressed: () {
  //                           onPressSendMessage();
  //                         },
  //                       ),
  //                     )
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ));
  // }

  // onPressSendMessage() async {
  //   var title = sellerChatTitleController.text.toString();
  //   var message = sellerChatMessageController.text.toString();

  //   if (title == "" || message == "") {
  //     ToastComponent.showDialog(AppLocalizations.of(context).product_details_screen_seller_chat_title_message_empty_warning, context,
  //         gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
  //     return;
  //   }

  //   var conversationCreateResponse = await ChatRepository()
  //       .getCreateConversationResponse(
  //           product_id: widget.id, title: title, message: message);

  //   if (conversationCreateResponse.result == false) {
  //     ToastComponent.showDialog(AppLocalizations.of(context).product_details_screen_seller_chat_creation_unable_warning, context,
  //         gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
  //     return;
  //   }

  //   Navigator.of(context, rootNavigator: true).pop();
  //   sellerChatTitleController.clear();
  //   sellerChatMessageController.clear();
  //   setState(() {});

  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return Chat(
  //       conversation_id: conversationCreateResponse.conversation_id,
  //       messenger_name: conversationCreateResponse.shop_name,
  //       messenger_title: conversationCreateResponse.title,
  //       messenger_image: conversationCreateResponse.shop_logo,
  //     );
  //     ;
  //   })).then((value) {
  //     onPopped(value);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SnackBar _addedToCartSnackbar = SnackBar(
      content: Text(
        AppLocalizations.of(context)!.product_details_screen_snackbar_added_to_cart,
        style: TextStyle(color: MyTheme.font_grey),
      ),
      backgroundColor: MyTheme.soft_accent_color,
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: AppLocalizations.of(context)!.product_details_screen_snackbar_show_cart,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Scaffold(); //Cart(has_bottomnav: false);
          })).then((value) {
            onPopped(value);
          });
        },
        textColor: MyTheme.accent_color,
        disabledTextColor: Colors.grey,
      ),
    );
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          bottomNavigationBar: buildBottomAppBar(context, _addedToCartSnackbar),
          backgroundColor: Colors.white,
          appBar: buildAppBar(statusBarHeight, context),
          body: RefreshIndicator(
            color: MyTheme.accent_color,
            backgroundColor: Colors.white,
            onRefresh: _onPageRefresh,
            child: CustomScrollView(
              controller: _mainScrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          0.0,
                          16.0,
                          0.0,
                        ),
                        child: buildProductImageSection(),
                      ),
                    ])),
                SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            8.0,
                            16.0,
                            0.0,
                          ),
                          child: //_productDetails != null
                          widget.product.prodNameAr!.isNotEmpty
                              ? Text(
                            widget.product.prodNameAr!,//_productDetails.name,
                            style: TextStyle(
                                fontSize: 16,
                                color: MyTheme.font_grey,
                                fontWeight: FontWeight.w600),
                            maxLines: 2,
                          )
                              : ShimmerHelper().buildBasicShimmer(
                            height: 30.0,
                          )),
                    ])),
                SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          8.0,
                          16.0,
                          0.0,
                        ),
                        child:// _productDetails != null
                        widget.product.id!.isNotEmpty
                            ? buildRatingAndWishButtonRow()
                            : ShimmerHelper().buildBasicShimmer(
                          height: 30.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          16.0,
                          16.0,
                          0.0,
                        ),
                        child:// _productDetails != null
                        widget.product.brandId!.isNotEmpty
                            ? buildBrandRow()
                            : ShimmerHelper().buildBasicShimmer(
                          height: 50.0,
                        ),
                      ),
                      const Divider(
                        height: 24.0,
                      ),
                    ])),
                SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          8.0,
                          16.0,
                          0.0,
                        ),
                        child: //_productDetails != null
                        widget.product.prodPrice!.isNotEmpty
                            ? buildMainPriceRow()
                            : ShimmerHelper().buildBasicShimmer(
                          height: 30.0,
                        ),
                      ),
                    ])),
                SliverList(
                    delegate: SliverChildListDelegate([
                      // AddonConfig.club_point_addon_installed
                      //     ? Padding(
                      //         padding: const EdgeInsets.fromLTRB(
                      //           16.0,
                      //           8.0,
                      //           16.0,
                      //           0.0,
                      //         ),
                      //         child: _productDetails != null
                      //             ? buildClubPointRow()
                      //             : ShimmerHelper().buildBasicShimmer(
                      //                 height: 30.0,
                      //               ),
                      //       )
                      //     : Container(),
                      const Divider(
                        height: 24.0,
                      ),
                    ])),
                // SliverList(
                //     delegate: SliverChildListDelegate([
                //   _productDetails != null
                //       ? buildChoiceOptionList()
                //       : buildVariantShimmers(),
                // ])),
                SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        16.0,
                        16.0,
                        16.0,
                        0.0,
                      ),
                      child: //_productDetails != null?

                      (_colorList.isNotEmpty
                          ? buildColorRow()
                          : Container())
                    // : ShimmerHelper().buildBasicShimmer(
                    //     height: 30.0,
                    //   ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          8.0,
                          16.0,
                          0.0,
                        ),
                        child:// _productDetails != null
                        widget.product.prodNo!.isNotEmpty
                            ? buildQuantityRow()
                            : ShimmerHelper().buildBasicShimmer(
                          height: 30.0,
                        ),
                      ),
                    ])),
                SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          16.0,
                          16.0,
                          0.0,
                        ),
                        child: //_productDetails != null
                        widget.product.prodPrice!.isNotEmpty
                            ? buildTotalPriceRow()
                            : ShimmerHelper().buildBasicShimmer(
                          height: 30.0,
                        ),
                      ),
                      const Divider(
                        height: 24.0,
                      ),
                    ])),
                // SliverList(
                //     delegate: SliverChildListDelegate([
                //   Padding(
                //     padding: const EdgeInsets.fromLTRB(
                //       16.0,
                //       0.0,
                //       16.0,
                //       0.0,
                //     ),
                //     child: //_productDetails != null
                //         ? buildSellerRow(context)
                //         : ShimmerHelper().buildBasicShimmer(
                //             height: 50.0,
                //           ),
                //   ),
                //   Divider(
                //     height: 24,
                //   ),
                // ])),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        16.0,
                        0.0,
                        16.0,
                        0.0,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.product_details_screen_description,
                        style: TextStyle(
                            color: MyTheme.font_grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        8.0,
                        0.0,
                        8.0,
                        8.0,
                      ),
                      child: //_productDetails != null
                      widget.product.prodDescAr!.isNotEmpty
                          ? buildExpandableDescription()
                          : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: ShimmerHelper().buildBasicShimmer(
                            height: 60.0,
                          )),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     if (_productDetails.video_link == "") {
                    //       ToastComponent.showDialog(
                    //           AppLocalizations.of(context).product_details_screen_video_not_available, context,
                    //           gravity: Toast.CENTER,
                    //           duration: Toast.LENGTH_LONG);
                    //       return;
                    //     }
                    //
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (context) {
                    //       return VideoDescription(
                    //         url: _productDetails.video_link,
                    //       );
                    //     })).then((value) {
                    //       onPopped(value);
                    //     });
                    //   },
                    //   child: Container(
                    //     height: 40,
                    //     child: Padding(
                    //       padding: const EdgeInsets.fromLTRB(
                    //         16.0,
                    //         0.0,
                    //         8.0,
                    //         0.0,
                    //       ),
                    //       child: Row(
                    //         children: [
                    //           Text(
                    //             AppLocalizations.of(context).product_details_screen_video,
                    //             style: TextStyle(
                    //                 color: MyTheme.font_grey,
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w600),
                    //           ),
                    //           Spacer(),
                    //           Icon(
                    //             Ionicons.ios_add,
                    //             color: MyTheme.font_grey,
                    //             size: 24,
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const Divider(
                    //   height: 1,
                    // ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const Scaffold(); //ProductReviews(id: widget.id); //todo product review screen
                            })).then((value) {
                          onPopped(value);
                        });
                      },
                      child: SizedBox(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            0.0,
                            8.0,
                            0.0,
                          ),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.product_details_screen_reviews,
                                style: TextStyle(
                                    color: MyTheme.font_grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              Icon(
                                Ionicons.add,
                                color: MyTheme.font_grey,
                                size: 24,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Divider(
                    //   height: 1,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (context) {
                    //       return CommonWebviewScreen(
                    //         url:
                    //             "${AppConfig.RAW_BASE_URL}/mobile-page/sellerpolicy",
                    //         page_name: AppLocalizations.of(context).product_details_screen_seller_policy,
                    //       );
                    //     }));
                    //   },
                    //   child: Container(
                    //     height: 40,
                    //     child: Padding(
                    //       padding: const EdgeInsets.fromLTRB(
                    //         16.0,
                    //         0.0,
                    //         8.0,
                    //         0.0,
                    //       ),
                    //       child: Row(
                    //         children: [
                    //           Text(
                    //             AppLocalizations.of(context).product_details_screen_seller_policy,
                    //             style: TextStyle(
                    //                 color: MyTheme.font_grey,
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w600),
                    //           ),
                    //           Spacer(),
                    //           Icon(
                    //             Ionicons.ios_add,
                    //             color: MyTheme.font_grey,
                    //             size: 24,
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Divider(
                    //   height: 1,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (context) {
                    //       return CommonWebviewScreen(
                    //         url:
                    //             "${AppConfig.RAW_BASE_URL}/mobile-page/returnpolicy",
                    //         page_name: AppLocalizations.of(context).product_details_screen_return_policy,
                    //       );
                    //     }));
                    //   },
                    //   child: Container(
                    //     height: 40,
                    //     child: Padding(
                    //       padding: const EdgeInsets.fromLTRB(
                    //         16.0,
                    //         0.0,
                    //         8.0,
                    //         0.0,
                    //       ),
                    //       child: Row(
                    //         children: [
                    //           Text(
                    //             AppLocalizations.of(context).product_details_screen_return_policy,
                    //             style: TextStyle(
                    //                 color: MyTheme.font_grey,
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w600),
                    //           ),
                    //           Spacer(),
                    //           Icon(
                    //             Ionicons.ios_add,
                    //             color: MyTheme.font_grey,
                    //             size: 24,
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Divider(
                    //   height: 1,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (context) {
                    //       return CommonWebviewScreen(
                    //         url:
                    //             "${AppConfig.RAW_BASE_URL}/mobile-page/supportpolicy",
                    //         page_name: AppLocalizations.of(context).product_details_screen_support_policy,
                    //       );
                    //     }));
                    //   },
                    //   child: Container(
                    //     height: 40,
                    //     child: Padding(
                    //       padding: const EdgeInsets.fromLTRB(
                    //         16.0,
                    //         0.0,
                    //         8.0,
                    //         0.0,
                    //       ),
                    //       child: Row(
                    //         children: [
                    //           Text(
                    //             AppLocalizations.of(context).product_details_screen_support_policy,
                    //             style: TextStyle(
                    //                 color: MyTheme.font_grey,
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w600),
                    //           ),
                    //           Spacer(),
                    //           Icon(
                    //             Ionicons.ios_add,
                    //             color: MyTheme.font_grey,
                    //             size: 24,
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const Divider(
                      height: 1,
                    ),
                  ]),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        16.0,
                        16.0,
                        16.0,
                        0.0,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.product_details_screen_products_may_like,
                        style: TextStyle(
                            color: MyTheme.font_grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        8.0,
                        16.0,
                        0.0,
                        0.0,
                      ),
                      child: buildProductsMayLikeList(),
                    )
                  ]),
                ),

                //  SliverList(
                //   delegate: SliverChildListDelegate([
                //     Padding(
                //       padding: const EdgeInsets.fromLTRB(
                //         16.0,
                //         16.0,
                //         16.0,
                //         0.0,
                //       ),
                //       child: Text(
                //         AppLocalizations.of(context)!.top_selling_products_screen_top_selling_products,
                //         style: TextStyle(
                //             color: MyTheme.font_grey,
                //             fontSize: 16,
                //             fontWeight: FontWeight.w600),
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.fromLTRB(
                //         16.0,
                //         16.0,
                //         16.0,
                //         0.0,
                //       ),
                //       child: buildTopSellingProductList(),
                //     )
                //   ]),
                // )
              ],
            ),
          )),
    );
  }

  // Row buildSellerRow(BuildContext context) {
  //   //print("sl:" + AppConfig.BASE_PATH + _productDetails.shop_logo);
  //   return Row(
  //     children: [
  //       _productDetails.added_by == "admin"
  //           ? Container()
  //           : Padding(
  //               padding: app_language_rtl.$ ? const EdgeInsets.only(left: 8.0) : const EdgeInsets.only(right: 8.0),
  //               child: Container(
  //                 width: 30,
  //                 height: 30,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(2.0),
  //                   border: Border.all(
  //                       color: const Color.fromRGBO(112, 112, 112, .3), width: 0.5),
  //                   //shape: BoxShape.rectangle,
  //                 ),
  //                 child: FadeInImage.assetNetwork(
  //                   placeholder: 'assets/placeholder.png',
  //                   image: AppConfig.BASE_PATH + _productDetails.shop_logo,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             ),
  //       Container(
  //         width: MediaQuery.of(context).size.width * (.5),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(AppLocalizations.of(context)!.product_details_screen_seller,
  //                 style: const TextStyle(
  //                   color: Color.fromRGBO(153, 153, 153, 1),
  //                 )),
  //             Text(
  //               _productDetails.shop_name,
  //               style: TextStyle(
  //                   color: MyTheme.font_grey,
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w600),
  //             )
  //           ],
  //         ),
  //       ),
  //       const Spacer(),
  //       Container(
  //           child: Row(
  //         children: [
  //           InkWell(
  //             onTap: () {
  //               if (is_logged_in == false) {
  //                 ToastComponent.showDialog("You need to log in", context,
  //                     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
  //                 return;
  //               }

  //               onTapSellerChat();
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 4.0),
  //               child: Text(
  //                 AppLocalizations.of(context)!.product_details_screen_chat_with_seller,
  //                 style: const TextStyle(
  //                     decoration: TextDecoration.underline,
  //                     color: Color.fromRGBO(7, 101, 136, 1),
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.w600),
  //               ),
  //             ),
  //           ),
  //           const Icon(Icons.message, size: 16, color: Color.fromRGBO(7, 101, 136, 1))
  //         ],
  //       ))
  //     ],
  //   );
  // }

  Row buildTotalPriceRow() {
    return Row(
      children: [
        Padding(
          padding: app_language_rtl.$ ? const EdgeInsets.only(left: 8.0) : const EdgeInsets.only(right: 8.0),
          child: SizedBox(
            width: 75,
            child: Text(
              AppLocalizations.of(context)!.product_details_screen_total_price,
              style: const TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
            ),
          ),
        ),
        Text(
          // _productDetails.currency_symbol //todo
          '\$' + _totalPrice.toString(),
          style: TextStyle(
              color: MyTheme.accent_color,
              fontSize: 18.0,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  Row buildQuantityRow() {
    return Row(
      children: [
        Padding(
          padding: app_language_rtl.$ ? const EdgeInsets.only(left: 8.0) : const EdgeInsets.only(right: 8.0),
          child: Container(
            width: 75,
            child: Text(
              AppLocalizations.of(context)!.product_details_screen_quantity,
              style: const TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
            ),
          ),
        ),
        Container(
          height: 36,
          width: 120,
          decoration: BoxDecoration(
              border:
              Border.all(color: const Color.fromRGBO(222, 222, 222, 1), width: 1),
              borderRadius: BorderRadius.circular(36.0),
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              buildQuantityDownButton(),
              Container(
                  width: 36,
                  child: Center(
                      child: Text(
                        _quantity.toString(),
                        style: TextStyle(fontSize: 18, color: MyTheme.dark_grey),
                      ))),
              buildQuantityUpButton()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "(${_stock} ${AppLocalizations.of(context)!.product_details_screen_available})",
            style: const TextStyle(
                color: Color.fromRGBO(152, 152, 153, 1), fontSize: 14),
          ),
        ),
      ],
    );
  }

  Padding buildVariantShimmers() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16.0,
        0.0,
        8.0,
        0.0,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: app_language_rtl.$ ? EdgeInsets.only(left: 8.0) : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                ),
                Padding(
                  padding: app_language_rtl.$ ? EdgeInsets.only(left: 8.0) : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                ),
                Padding(
                  padding: app_language_rtl.$ ? EdgeInsets.only(left: 8.0) : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                ),
                Padding(
                  padding: app_language_rtl.$ ? EdgeInsets.only(left: 8.0) : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: app_language_rtl.$ ? EdgeInsets.only(left: 8.0) : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                ),
                Padding(
                  padding: app_language_rtl.$ ? EdgeInsets.only(left: 8.0) : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                ),
                Padding(
                  padding: app_language_rtl.$ ? EdgeInsets.only(left: 8.0) : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                ),
                Padding(
                  padding: app_language_rtl.$ ? EdgeInsets.only(left: 8.0) : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // buildChoiceOptionList() {
  //   return ListView.builder(
  //     itemCount: _productDetails.choice_options.length,
  //     scrollDirection: Axis.vertical,
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemBuilder: (context, index) {
  //       return Padding(
  //         padding: const EdgeInsets.only(bottom: 8.0),
  //         child: buildChoiceOpiton(_productDetails.choice_options, index),
  //       );
  //     },
  //   );
  // }

  // buildChoiceOpiton(choice_options, choice_options_index) {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(
  //       16.0,
  //       8.0,
  //       16.0,
  //       0.0,
  //     ),
  //     child: Row(
  //       children: [
  //         Padding(
  //           padding: app_language_rtl.$ ? const EdgeInsets.only(left: 8.0) : const EdgeInsets.only(right: 8.0),
  //           child: Container(
  //             width: 75,
  //             child: Text(
  //               choice_options[choice_options_index].title,
  //               style: const TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
  //             ),
  //           ),
  //         ),
  //         Container(
  //           height: 40,
  //           width: MediaQuery.of(context).size.width - (75 + 40),
  //           child: Scrollbar(
  //             controller: _variantScrollController,
  //             isAlwaysShown: false,
  //             child: ListView.builder(
  //               itemCount: choice_options[choice_options_index].options.length,
  //               scrollDirection: Axis.horizontal,
  //               shrinkWrap: true,
  //               itemBuilder: (context, index) {
  //                 return Padding(
  //                   padding: const EdgeInsets.only(bottom: 8.0),
  //                   child: buildChoiceItem(
  //                       choice_options[choice_options_index].options[index],
  //                       choice_options_index,
  //                       index),
  //                 );
  //               },
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // buildChoiceItem(option, choice_options_index, index) {
  //   return Padding(
  //     padding: app_language_rtl.$ ? const EdgeInsets.only(left: 8.0) : const EdgeInsets.only(right: 8.0),
  //     child: InkWell(
  //       onTap: () {
  //         _onVariantChange(choice_options_index, option);
  //       },
  //       child: Container(
  //         decoration: BoxDecoration(
  //           border: Border.all(
  //               color: _selectedChoices[choice_options_index] == option
  //                   ? MyTheme.accent_color
  //                   : const Color.fromRGBO(224, 224, 225, 1),
  //               width: 1.5),
  //           borderRadius: BorderRadius.circular(3.0),
  //         ),
  //         child: Padding(
  //           padding:
  //               const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
  //           child: Center(
  //             child: Text(
  //               option,
  //               style: TextStyle(
  //                   color: _selectedChoices[choice_options_index] == option
  //                       ? MyTheme.accent_color
  //                       : const Color.fromRGBO(224, 224, 225, 1),
  //                   fontSize: 12.0,
  //                   fontWeight: FontWeight.w600),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  buildColorRow() {
    return Row(
      children: [
        Padding(
          padding: app_language_rtl.$ ? const EdgeInsets.only(left: 8.0) : const EdgeInsets.only(right: 8.0),
          child: Container(
            width: 75,
            child: Text(
              AppLocalizations.of(context)!.product_details_screen_color,
              style: const TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
            ),
          ),
        ),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width - (75 + 40),
          child: Scrollbar(
            controller: _colorScrollController,
            isAlwaysShown: false,
            child: ListView.builder(
              itemCount: _colorList.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: buildColorItem(index),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  buildColorItem(index) {
    return Padding(
      padding: app_language_rtl.$ ? const EdgeInsets.only(left: 8.0) : const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          _onColorChange(index);
        },
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(
                  color: _selectedColorIndex == index
                      ? Colors.purple
                      : Colors.white,
                  width: 1),
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(222, 222, 222, 1), width: 1),
                borderRadius: BorderRadius.circular(16.0),
                color: _colorList[index],),       //ColorHelper.getColorFromColorCode(_colorList[index])),
              child: _selectedColorIndex == index
                  ? buildColorCheckerContainer()
                  : Container(),
            ),
          ),
        ),
      ),
    );
  }

  buildColorCheckerContainer() {
    return Padding(
        padding: const EdgeInsets.all(3),
        child: /*Icon(FontAwesome.check, color: Colors.white, size: 16),*/
        Image.asset(
          "assets/white_tick.png",
          width: 16,
          height: 16,
        ));
  }

  // Row buildClubPointRow() {
  //   return Row(
  //     children: [
  //       Padding(
  //         padding: app_language_rtl.$ ? const EdgeInsets.only(left: 8.0) : const EdgeInsets.only(right: 8.0),
  //         child: Container(
  //           width: 75,
  //           child: Text(
  //             AppLocalizations.of(context)!.product_details_screen_club_point,
  //             style: const TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
  //           ),
  //         ),
  //       ),
  //       Container(
  //         decoration: BoxDecoration(
  //             border: Border.all(color: MyTheme.golden, width: 1),
  //             borderRadius: BorderRadius.circular(16.0),
  //             color: const Color.fromRGBO(253, 235, 212, 1)),
  //         child: Padding(
  //           padding:
  //               const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
  //           child: Text(
  //             _productDetails.earn_point.toString(),
  //             style: TextStyle(color: MyTheme.golden, fontSize: 12.0),
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  Row buildMainPriceRow() {
    return Row(
      children: [
        Padding(
          padding: app_language_rtl.$ ? const EdgeInsets.only(left: 8.0) : const EdgeInsets.only(right: 8.0),
          child: Container(
            width: 75,
            child: Text(
              AppLocalizations.of(context)!.product_details_screen_price,
              style: const TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
            ),
          ),
        ),
        //_productDetails.has_discount
        widget.product.isOffer!.compareTo("true")==0
            ? Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text( widget.product.prodPrice!,    //_productDetails.stroked_price,
              style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Color.fromRGBO(224, 224, 225, 1),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600)),
        )
            : Container(),
        // Text(
        //   _singlePriceString,
        //   //"singleprice",
        //   style: TextStyle(
        //       color: MyTheme.accent_color,
        //       fontSize: 18.0,
        //       fontWeight: FontWeight.w600),
        // )
      ],
    );
  }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: SizedBox(
        height: kToolbarHeight +
            statusBarHeight -
            (MediaQuery.of(context).viewPadding.top > 40 ? 32.0 : 16.0),
        //MediaQuery.of(context).viewPadding.top is the statusbar height, with a notch phone it results almost 50, without a notch it shows 24.0.For safety we have checked if its greater than thirty
        // SizedBox(
        //     width: 300,
        //     child: Padding(
        //       padding: const EdgeInsets.only(top: 22.0),
        //       child: Text(
        //         _appbarPriceString,
        //         style: TextStyle(fontSize: 16, color: MyTheme.font_grey),
        //       ),
        //     )),
      ),
      elevation: 0.0,
      titleSpacing: 0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: IconButton(
            icon: Icon(Icons.share_outlined, color: MyTheme.dark_grey),
            onPressed: () {
              //   onPressShare(context); //todo make share button
            },
          ),
        ),
      ],
    );
  }

  buildBottomAppBar(BuildContext context, _addedToCartSnackbar) {
    return Builder(builder: (BuildContext context) {
      return BottomAppBar(
        child: Container(
          color: Colors.transparent,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FlatButton(
                  minWidth: MediaQuery.of(context).size.width /2-0.5,
                  height: 30,
                  color: MyTheme.golden,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.product_details_screen_button_add_to_cart,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    onPressAddToCart(context, _addedToCartSnackbar);  //todo add to cart button
                  },
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              IconButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder:(context){
                  return const CartScreen(has_bottomnav: false,);
                }), );
              }, icon: const Icon(Icons.shopping_cart_outlined),
              ),

              IconButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder:(context){
                  return Main();
                }), );
              }, icon: const Icon(Icons.home_outlined),
              ),
              const SizedBox(
                width:5,
              ),

              // FlatButton(
              //   minWidth: MediaQuery.of(context).size.width / 2 - .5,
              //   height: 50,
              //   color: MyTheme.accent_color,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(0.0),
              //   ),
              //   child: Text(
              //     AppLocalizations.of(context)!.product_details_screen_button_buy_now,
              //     style: const TextStyle(
              //         color: Colors.white,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w600),
              //   ),
              //   onPressed: () {
              //    // onPressBuyNow(context); //todo make by now button
              //   },
              // )

            ],
          ),
        ),
      );
    });
  }

  buildRatingAndWishButtonRow() {
    return Row(
      children: [
        RatingBar(
          itemSize: 18.0,
          ignoreGestures: true,
          initialRating: double.parse("0"),//_productDetails.rating.toString()),//todo add intial rating
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          ratingWidget: RatingWidget(
            full: const Icon(FontAwesomeIcons.star, color: Colors.amber),
            empty:
            const Icon(FontAwesomeIcons.star, color: Color.fromRGBO(224, 224, 225, 1)),
            half: const Icon(FontAwesomeIcons.star, color: Colors.amber),
          ),
          itemPadding: const EdgeInsets.only(right: 1.0),
          onRatingUpdate: (rating) {
            //print(rating);
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            "(" + "0"  +")",//_productDetails.rating_count.toString() + ")",//todo add rating count
            style: TextStyle(
                color: Color.fromRGBO(152, 152, 153, 1), fontSize: 14),
          ),
        ),
        const Spacer(),
        _isInWishList
            ? InkWell(
          onTap: () {
            onWishTap(); //todo on wish tap
          },
          child: const Icon(
            FontAwesomeIcons.solidHeart,
            color: Color.fromRGBO(230, 46, 4, 1),
            size: 20,
          ),
        )
            : InkWell(
          onTap: () {
            onWishTap(); //todo on wish tap
          },
          child: const Icon(
            FontAwesomeIcons.heart,
            color: Color.fromRGBO(230, 46, 4, 1),
            size: 20,
          ),
        )
      ],
    );
  }

  buildBrandRow() {
    return// _productDetails.brand.id > 0
      widget.product.brandId!.isNotEmpty
          ? InkWell(
        onTap: () { //todo nav to brand screen
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Scaffold();//widget.product.brandId //BrandProducts(id: _productDetails.brand.id,brand_name: _productDetails.brand.name,);
          }));
        },
        child: Row(
          children: [
            Padding(
              padding: app_language_rtl.$ ? const EdgeInsets.only(left: 8.0) : const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                width: 75,
                child: Text(
                  AppLocalizations.of(context)!.product_details_screen_brand,
                  style: const TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                widget.product.brandNameAr!, //_productDetails.brand.name,
                style: const TextStyle(
                    color: Color.fromRGBO(152, 152, 153, 1), fontSize: 16),
              ),
            ),
            const Spacer(),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: const Color.fromRGBO(112, 112, 112, .3), width: 1),
                //shape: BoxShape.rectangle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  'assets/1.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),

                // FadeInImage.assetNetwork(
                //   placeholder: 'assets/placeholder.png',
                //   image: AppConfig.BASE_PATH + widget.product.prodImg!,//todo convert to brand img //_productDetails.brand.logo,
                //   fit: BoxFit.contain,
                // ),
              ),
            ),
          ],
        ),
      )
          : Container();
  }

  ExpandableNotifier buildExpandableDescription() {
    return ExpandableNotifier(
        child: ScrollOnExpand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expandable(
                collapsed: SizedBox(
                    height: 50,
                    child: Html(data:widget.product.prodDescAr)//_productDetails.description)
                ),
                expanded: Container(child: Html(data: widget.product.prodDescAr)),//_productDetails.description)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Builder(
                    builder: (context) {
                      var controller = ExpandableController.of(context);
                      return FlatButton(
                        child: Text(
                          !controller!.expanded ? AppLocalizations.of(context)!.common_view_more : AppLocalizations.of(context)!.common_show_less,
                          style: TextStyle(color: MyTheme.font_grey, fontSize: 11),
                        ),
                        onPressed: () {
                          controller.toggle();
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  // buildTopSellingProductList() {
  //   if (_topProductInit == false && _topProducts.length == 0) {
  //     return Column(
  //       children: [
  //         Padding(
  //             padding: const EdgeInsets.only(top: 8.0),
  //             child: ShimmerHelper().buildBasicShimmer(
  //               height: 75.0,
  //             )),
  //         Padding(
  //             padding: const EdgeInsets.only(top: 8.0),
  //             child: ShimmerHelper().buildBasicShimmer(
  //               height: 75.0,
  //             )),
  //         Padding(
  //             padding: const EdgeInsets.only(top: 8.0),
  //             child: ShimmerHelper().buildBasicShimmer(
  //               height: 75.0,
  //             )),
  //       ],
  //     );
  //   } else if (_topProducts.length > 0) {
  //     return SingleChildScrollView(
  //       child: ListView.builder(
  //         itemCount: _topProducts.length,
  //         scrollDirection: Axis.vertical,
  //         physics: NeverScrollableScrollPhysics(),
  //         shrinkWrap: true,
  //         itemBuilder: (context, index) {
  //           return Padding(
  //             padding: const EdgeInsets.only(bottom: 3.0),
  //             child: ListProductCard(
  //                 id: _topProducts[index].id,
  //                 image: _topProducts[index].thumbnail_image,
  //                 name: _topProducts[index].name,
  //                 main_price: _topProducts[index].main_price,
  //                 stroked_price: _topProducts[index].stroked_price,
  //                 has_discount: _topProducts[index].has_discount),
  //           );
  //         },
  //       ),
  //     );
  //   } else {
  //     return Container(
  //         height: 100,
  //         child: Center(
  //             child: Text(AppLocalizations.of(context)!.product_details_screen_no_top_selling_product,
  //                 style: TextStyle(color: MyTheme.font_grey))));
  //   }
  // }

  buildProductsMayLikeList() {


    if (_relatedProductInit == false && _relatedProducts.length == 0) {
      return Row(
        children: [
          Padding(
              padding: app_language_rtl.$ ? EdgeInsets.only(left: 8.0) : EdgeInsets.only(right: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
          Padding(
              padding: app_language_rtl.$ ? EdgeInsets.only(left: 8.0) : EdgeInsets.only(right: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
          Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
        ],
      );
    } else if (_relatedProducts.length > 0) {
      return SingleChildScrollView(
        child: SizedBox(
          height: 175,
          child: ListView.builder(
            itemCount: _relatedProducts.length,
            scrollDirection: Axis.horizontal,
            itemExtent: 120,
            itemBuilder: (context, index) {
              RelatedProducts currRelPr=_relatedProducts[index];
              List<String> prImgs=[currRelPr.prodImg!];
              Products currProd=Products(id:currRelPr.prodId ,prodPrice:currRelPr.prodPrice ,prodNo:currRelPr.prodNo ,
                  prodImg:currRelPr.prodImg ,prodNameAr:currRelPr.prodNameAr ,prodNameEn:currRelPr.prodNameEn ,
                  prodNameTr:currRelPr.prodNameTr,brandId:currRelPr.brandId ,prodDescAr:currRelPr.prodDescAr ,
                  prodDescEn:currRelPr.prodDescEn ,prodDescTr:currRelPr.prodDescTr ,isOffer:currRelPr.isOffer,
                  brandNameAr:currRelPr.brandNameAr ,brandNameEn:currRelPr.brandNameEn ,
                  brandNameTr:currRelPr.brandNameTr, images:prImgs);

              return Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: MiniProductCard(
                    relProd: currProd
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                AppLocalizations.of(context)!.product_details_screen_no_related_product,
                style: TextStyle(color: MyTheme.font_grey),
              )));
    }
  }

  buildQuantityUpButton() => SizedBox(
    width: 36,
    child: IconButton(
        icon: Icon(FontAwesomeIcons.plus, size: 16, color: MyTheme.dark_grey),
        onPressed: () {
          if (_quantity < _stock) {
            _quantity++;
            setState(() {});
            calculateTotalPrice();
          }
        }),
  );

  buildQuantityDownButton() => SizedBox(
      width: 36,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.minus, size: 16, color: MyTheme.dark_grey),
          onPressed: () {
            if (_quantity > 1) {
              _quantity--;
              setState(() {});
              calculateTotalPrice();
            }
          }));

  openPhotoDialog(BuildContext context, path) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
            child: Stack(
              children: [
                PhotoView(
                  enableRotation: true,
                  heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
                  imageProvider: NetworkImage(path),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: ShapeDecoration(
                      color: MyTheme.medium_grey_50,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                        ),
                      ),
                    ),
                    width: 40,
                    height: 40,
                    child: IconButton(
                      icon: Icon(Icons.clear, color: MyTheme.white),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    ),
                  ),
                ),
              ],
            )),
      );
    },
  );

  buildProductImageSection() {
    if (_productImageList.isEmpty) {
      return Row(
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 40.0, width: 40.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 40.0, width: 40.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 40.0, width: 40.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 40.0, width: 40.0),
                ),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                height: 190.0,
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            width: 64,
            child: Scrollbar(
              controller: _imageScrollController,
              isAlwaysShown: false,
              thickness: 4.0,
              child: Padding(
                padding: app_language_rtl.$ ? const EdgeInsets.only(left: 8.0) : const EdgeInsets.only(right: 8.0),
                child: ListView.builder(
                    itemCount:_productImageList.length, //todo
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      int itemIndex = index;
                      return GestureDetector(
                        onTap: () {
                          _currentImage = itemIndex;
                          //  print(_currentImage);
                          setState(() {});
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: _currentImage == itemIndex
                                    ? MyTheme.accent_color
                                    : const Color.fromRGBO(112, 112, 112, .3),
                                width: _currentImage == itemIndex ? 2 : 1),
                            //shape: BoxShape.rectangle,
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: _productImageList.isEmpty?
                              /*Image.asset(
                                        singleProduct.product_images[index])*/
                              //todo convert to network img
                              Image.asset(
                                'assets/1.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ):
                              FadeInImage.assetNetwork(
                                placeholder: 'assets/1.jpg',
                                image:
                                _productImageList[index],
                                fit: BoxFit.contain,
                              )),
                        ),
                      );
                    }),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              openPhotoDialog(context,_productImageList[_currentImage]);//todo
              // AppConfig.BASE_PATH + _productImageList[_currentImage]);
            },
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width - 96,
              child: Container(
                child:  _productImageList.isEmpty?
                Image.asset(
                  'assets/1.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ):
                //todo comvert to network img

                FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder_rectangle.png',
                  image: _productImageList[_currentImage],
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}