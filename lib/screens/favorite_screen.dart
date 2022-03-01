import 'package:elhasnaa/data_model/fav_model.dart';
import 'package:elhasnaa/data_model/products.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/helpers/shimmer_helper.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/repositories/add_fav_repo.dart';
import 'package:elhasnaa/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  ScrollController _mainScrollController = ScrollController();

  //init
  bool _wishlistInit = true;
  List<FavModel> _wishlistItems = [];

  @override
  void initState() {
    if (is_logged_in.$ == true) {
      fetchWishlistItems();
    }

    super.initState();
  }

  @override
  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }

  fetchWishlistItems() async {
    var wishlistResponse = await Favorites().getWishList(user_id.$);
    _wishlistItems.addAll(wishlistResponse);
    _wishlistInit = false;
    setState(() {});
  }

  reset() {
    _wishlistInit = true;
    _wishlistItems.clear();
    setState(() {});
  }

  Future<void> _onPageRefresh() async {
    reset();
    fetchWishlistItems();
  }

  Future<void> _onPressRemove(index) async {
    var wishlist_id = _wishlistItems[index].id;
    _wishlistItems.removeAt(index);
    setState(() {});

    // var wishlistDeleteResponse =
    //     await WishListRepository().delete(wishlist_id: wishlist_id);

    // if (wishlistDeleteResponse.result == true) {
    //   ToastComponent.showDialog(wishlistDeleteResponse.message, context,
    //       gravity: Toast.TOP, duration: Toast.LENGTH_SHORT);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(context),
          body: RefreshIndicator(
            color: MyTheme.accent_color,
            backgroundColor: Colors.white,
            onRefresh: _onPageRefresh,
            child: CustomScrollView(
              controller: _mainScrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                      buildWishlist(),
                    ])),
              ],
            ),
          )),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        AppLocalizations.of(context)!.main_drawer_my_wishlist,
        style: TextStyle(fontSize: 16, color: MyTheme.accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  buildWishlist() {
    if (is_logged_in.$ == false) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                AppLocalizations.of(context)!.wishlist_screen_login_warning,
                style: TextStyle(color: MyTheme.font_grey),
              )));
    } else if (_wishlistInit == true && _wishlistItems.isEmpty) {
      return SingleChildScrollView(
        child: ShimmerHelper().buildListShimmer(item_count: 10),
      );
    } else if (_wishlistItems.isNotEmpty) {
      return SingleChildScrollView(
        child: ListView.builder(
          itemCount: _wishlistItems.length,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: buildWishListItem(index),
            );
          },
        ),
      );
    } else {
      return Container(
          height: 100,
          child: Center(
              child: Text(AppLocalizations.of(context)!.common_no_item_is_available,
                  style: TextStyle(color: MyTheme.font_grey))));
    }
  }

  buildWishListItem(index) {
    FavModel currFavpr=_wishlistItems[index];
    List<String> prImgs=[currFavpr.prodImg!];
    Products currProd=Products(id:currFavpr.prodId ,prodPrice:currFavpr.prodPrice ,prodNo:currFavpr.prodNo ,
        prodImg:currFavpr.prodImg ,prodNameAr:currFavpr.prodNameAr ,prodNameEn:currFavpr.prodNameEn ,
        prodNameTr:currFavpr.prodNameTr,brandId:currFavpr.brandId ,prodDescAr:currFavpr.prodDescAr ,
        prodDescEn:currFavpr.prodDescEn ,prodDescTr:currFavpr.prodDescTr ,isOffer:currFavpr.isOffer,
        brandNameAr:currFavpr.brandNameAr ,brandNameEn:currFavpr.brandNameEn ,
        brandNameTr:currFavpr.brandNameTr, images:prImgs);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetails(
            product: currProd ,
          );
        }));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: MyTheme.light_grey, width: 1.0),
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 0.0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width *0.27,
                        height: MediaQuery.of(context).size.width *0.27,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(16), right: Radius.zero),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/placeholder.png',
                              image: 'https://alhasnaa.site/files/' +
                                  _wishlistItems[index].prodImg!,
                              fit: BoxFit.cover,
                            ))),
                    SizedBox(
                      width:MediaQuery.of(context).size.width *0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Text(
                              _wishlistItems[index].prodNameAr!,//todo localization
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  color: MyTheme.font_grey,
                                  fontSize: 14,
                                  height: 1.6,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                            child: Text(
                              _wishlistItems[index].prodPrice!+" \$",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: MyTheme.accent_color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
          app_language_rtl.$
              ? Positioned(
            bottom: 8,
            left: 12,
            child: IconButton(
              icon: Icon(Icons.delete_forever_outlined,
                  color: MyTheme.medium_grey),
              onPressed: () {
                _onPressRemove(index);
              },
            ),
          )
              : Positioned(
            bottom: 8,
            right: 12,
            child: IconButton(
              icon: Icon(Icons.delete_forever_outlined,
                  color: MyTheme.medium_grey),
              onPressed: () {
                _onPressRemove(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}