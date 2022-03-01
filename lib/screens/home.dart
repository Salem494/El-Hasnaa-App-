import 'package:elhasnaa/data_model/brands.dart';
import 'package:elhasnaa/data_model/category_response.dart';
import 'package:elhasnaa/data_model/get_vendors.dart';
import 'package:elhasnaa/data_model/products.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/helpers/shimmer_helper.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/repositories/add_cart_repo.dart';
import 'package:elhasnaa/repositories/category_repository.dart';
import 'package:elhasnaa/repositories/getBrands.dart';
import 'package:elhasnaa/repositories/get_All_Vendors.dart';
import 'package:elhasnaa/screens/All_Brands.dart';
import 'package:elhasnaa/screens/brandDetails.dart';
import 'package:elhasnaa/screens/category_details.dart';
import 'package:elhasnaa/ui_elements/drawer.dart';
import 'package:elhasnaa/ui_elements/productGridView.dart';
import 'package:elhasnaa/ui_elements/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'All_Categories.dart';

class Home extends StatefulWidget {
  Home({Key? key, this.showBackButton = false, goBack = true})
      : super(key: key);
  bool? goBack;
  bool? showBackButton;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Categories> _featuredCategoryList = [];
  bool _isCategoryInitial = true;
  final ScrollController _mainScrollController = ScrollController();

  fetchFeaturedCategories() async {
    var categoryResponse = await CategoryRepository().getFeturedCategories();
    _featuredCategoryList.addAll(categoryResponse);
    print("homeeee fetch featured categ ---------------- ");
    print(_featuredCategoryList);
    _isCategoryInitial = false;
    setState(() {});
  }

  reset() {
    //_carouselImageList.clear();
    _featuredCategoryList.clear();
    //_isCarouselInitial = true;
    _isCategoryInitial = true;

    setState(() {});

    //resetProductList();
  }

  Future<void> _onRefresh() async {
    reset();
    fetchAll();
  }

  fetchAll() {
    // fetchCarouselImages();
    fetchFeaturedCategories();
    //fetchFeaturedProducts();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // In initState()

    fetchAll();

    _mainScrollController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: () async {
        return widget.goBack!;
      },
      child: Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            appBar: buildAppBar(statusBarHeight, context),
            drawer: const MainDrawer(),
            body:  Stack(
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
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Container(),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BuildSlider(),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .home_screen_featured_categories,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),

                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllCategories()));
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 70,
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,size: 15,),
                                            Text( AppLocalizations.of(context)!
                                                .all,style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15
                                            ),),
                                            SizedBox(width: 4,),
                                            Icon(Icons.arrow_forward_ios,size: 15,),

                                          ],
                                        )
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            8.0,
                            8.0,
                            0.0,
                            0.0,
                          ),
                          child: SizedBox(
                            height: 130,
                            child: buildHomeFeaturedCategories(context),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                            [
//                          Image.asset('assets/2.png',fit: BoxFit.cover,),
                          Container(
                            height: 10,
                          ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                      left: 10
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .brand,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),

                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AllBrands()));
                                    },
                                    child: Container(
                                        height: 25,
                                        width: 70,
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,size: 15,),
                                            Text( AppLocalizations.of(context)!
                                                .all,style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15
                                            ),),
                                            SizedBox(width: 4,),
                                            Icon(Icons.arrow_forward_ios,size: 15,),
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5,right: 5),
                                child: buildBrands(),
                              ),
//                              SizedBox(height: 15,),
//
//                              Row(
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                children: [
//                                  Padding(
//                                    padding: const EdgeInsets.only(
//                                        right: 10,
//                                        left: 10
//                                    ),
//                                    child: Text(
//                                      AppLocalizations.of(context)!
//                                          .all_vendors,
//                                      style: const TextStyle(
//                                        fontSize: 16,
//                                      ),
//                                    ),
//                                  ),
//
//                                  InkWell(
//                                    onTap: (){
//                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorScreen()));
//                                    },
//                                    child: Container(
//                                        height: 25,
//                                        width: 70,
//                                        child: Row(
//                                          children: [
//                                            Icon(Icons.arrow_back_ios,size: 15,),
//                                            Text( AppLocalizations.of(context)!
//                                                .all,style: TextStyle(
//                                                color: Colors.black,
//                                                fontWeight: FontWeight.w400,
//                                                fontSize: 15
//                                            ),),
//                                            SizedBox(width: 4,),
//                                            Icon(Icons.arrow_forward_ios,size: 15,),
//
//                                          ],
//                                        )
//                                    ),
//                                  ),
//                                ],
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.only(left: 10,right: 10),
//                                child: buildVendor(),
//                              ),
                              Container(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5,left: 5),
                                child: ProductGridView(),
                              )
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }



 //Brands
  Widget buildBrands(){
    return FutureBuilder(
        future: BrandsRepo().fetchBrands(),
        builder: (context,s){
          final List<Brands> brands = s.data as List<Brands>;
          if(s.hasData){
             return SizedBox(
               height: 150,
               width: 80,
               child: ListView.builder(
                 scrollDirection: Axis.horizontal,
                 itemBuilder: (c,i){
                   return  GestureDetector(
                     onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BrandDetails(brands:  brands[i]);
                       }));
                     },
                     child: Column(
                       children: [
                         Card(
                           clipBehavior: Clip.antiAliasWithSaveLayer,
                           shape: CircleBorder(
                             side: new BorderSide(color: MyTheme.golden.withOpacity(0.4), width: 1.0),
//
//                           borderRadius: BorderRadius.circular(16.0),
                           ),
                           elevation: 5.0,
                           child: Container(
                             width: 100,
                               height: 80,
                               child: ClipRRect(
                                   borderRadius: BorderRadius.vertical(
                                       top: Radius.circular(16),
                                       bottom: Radius.zero),
                                   child:brands[i].catIcone == ""?Image.asset('assets/1.jpg') :Image.network('https://alhasnaa.site/files/'+brands[i].catIcone.toString())
                               )),
                         ),
                         SizedBox(height: 10),
                         Expanded(child: Text(brands[i].catNameAr.toString(),style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 15,
                         ),)),
                       ],
                     ),
                   );
                 },
                 itemCount: brands.length,
               ),
             );
          }else if(!s.hasData){
           return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ShimmerHelper().buildBasicShimmer(
                        height: 120.0,
                        width: (MediaQuery.of(context).size.width - 32) / 3),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ShimmerHelper().buildBasicShimmer(
                          height: 120.0,
                          width: (MediaQuery.of(context).size.width - 32) / 3)),
                  Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ShimmerHelper().buildBasicShimmer(
                          height: 120.0,
                          width: (MediaQuery.of(context).size.width - 32) / 3)),
                ],
              ),
            );
          }else{
            return CircularProgressIndicator();
          }
        }
        );
  }

 //Vendor
//  Widget buildVendor(){
//    return FutureBuilder(
//        future: fetchVendors(),
//        builder: (context,s){
//          final List<getVendors> vendor = s.data as List<getVendors>;
//          if(s.hasData){
//            return SingleChildScrollView(
//              child: Padding(
//                padding: const EdgeInsets.only(left: 15,right: 15),
//                child: SizedBox(
//                  height: 150,
//                  child: ListView.builder(
//                      scrollDirection: Axis.horizontal,
//                      itemCount: 4,
//                      itemExtent: 100,
//                      itemBuilder: (context, index) {
//                        return Card(
//                          elevation: 8.0,
//                          child: Padding(
//                            padding: const EdgeInsets.all(5.0),
//                            child: Container(
//                              width: double.infinity,
//                              height: MediaQuery.of(context).size.height * 0.1,
//                              child: Padding(
//                                padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 2), /////3
//                                child: GestureDetector(
//                                  onTap: () {
//                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                      return VendorDetails(vendor: vendor[index]);
//                                    }));
//                                  },
//                                  child: SizedBox(
//                                    height: 100,
//                                    width: MediaQuery.of(context).size.width / 5 - 4,
//                                    child: Column(
//                                      children: [
//                                        Container(
//                                          height: 70,
//                                          ///57
//                                          width: 70,
//                                          child:
//                                          //'assets/placeholder.png'
//                                          vendor[index].logo!.isEmpty
//                                              ? Container(
//                                            decoration: BoxDecoration(
//                                              borderRadius: BorderRadius.circular(15),
//                                            ),
//                                            width: 80,
//                                            height: 50,
//                                            child: Image.asset(
//                                              'assets/1.jpg',
////                                        fit: BoxFit.cover,
//                                              width: double.infinity,
//                                            ),
//                                          )
//                                              : Container(
//                                            width: 80,
//                                            height: 50,
//                                            child: Image.network(
//                                              'https://alhasnaa.site/files/' +
//                                                  vendor[index]
//                                                      .logo!, /////
//                                              fit: BoxFit.cover,
//                                              width: double.infinity,
//                                            ),
//                                          ),
//                                        ),
//                                        Expanded(
//                                          child: Padding(
//                                            padding: const EdgeInsets.only(top: 8),
//                                            child: Text(
//                                              vendor[index].vendorName.toString(),
//                                              textAlign: TextAlign.center,
//                                              style: const TextStyle(
//                                                  color: Colors.grey,
//                                                  fontSize: 18,
//                                                  fontWeight: FontWeight.w800),
//                                            ),
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//                        );
//                      }),
//                ),
//              ),
//            );
//          }else if(!s.hasData){
//            return SingleChildScrollView(
//              scrollDirection: Axis.horizontal,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: [
//                  Padding(
//                    padding: const EdgeInsets.all(5.0),
//                    child: ShimmerHelper().buildBasicShimmer(
//                        height: 120.0,
//                        width: (MediaQuery.of(context).size.width - 32) / 3),
//                  ),
//                  Padding(
//                      padding: const EdgeInsets.only(right: 8.0),
//                      child: ShimmerHelper().buildBasicShimmer(
//                          height: 120.0,
//                          width: (MediaQuery.of(context).size.width - 32) / 3)),
//                  Padding(
//                      padding: const EdgeInsets.only(right: 8.0),
//                      child: ShimmerHelper().buildBasicShimmer(
//                          height: 120.0,
//                          width: (MediaQuery.of(context).size.width - 32) / 3)),
//                ],
//              ),
//            );
//          }else{
//            return CircularProgressIndicator();
//          }
//        }
//    );
//  }




  //appBar
  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        child: widget.showBackButton!
            ? Builder(
                builder: (context) => IconButton(
                    icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
                    onPressed: () {
                      if (!widget.goBack!) {
                        return;
                      }
                      return Navigator.of(context).pop();
                    }),
              )
            : Builder(
                builder: (context) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 0.0),
                  child: Container(
                    child: Image.asset(
                      'assets/hamburger.png',
                      height: 16,
                      //color: MyTheme.dark_grey,
                      color: MyTheme.dark_grey,
                    ),
                  ),
                ),
              ),
      ),
      title: SizedBox(
        height: kToolbarHeight +
            statusBarHeight -
            (MediaQuery.of(context).viewPadding.top > 40 ? 16.0 : 16.0),
        //MediaQuery.of(context).viewPadding.top is the statusbar height, with a notch phone it results almost 50, without a notch it shows 24.0.For safety we have checked if its greater than thirty
        child: Container(
          child: Padding(
              padding: app_language_rtl.$
                  ? const EdgeInsets.only(top: 14.0, bottom: 14, left: 12)
                  : const EdgeInsets.only(top: 14.0, bottom: 14, right: 12),
              // when notification bell will be shown , the right padding will cease to exist.
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const Scaffold(); //Filter();
                    }));
                  },
                  child: buildHomeSearchBox(context))),
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
}

  //Top Search
  buildHomeSearchBox(BuildContext context) {
    return TextField(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const Scaffold(); //Filter();
        }));
      },
      autofocus: false,
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.home_screen_search,
          hintStyle:
              const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyTheme.golden, width: 2),
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyTheme.golden, width: 2.0),
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
//             icon: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Icon(
//                 Icons.search,
//                 color: MyTheme.golden,
//                 size: 20,
//               ),
//             ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: MyTheme.golden,
              size: 20,
            ),
          ),
          contentPadding: const EdgeInsets.all(0.0)),
    );
  }


  buildHomeFeaturedCategories(context) {
    if (_isCategoryInitial && _featuredCategoryList.isEmpty) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ShimmerHelper().buildBasicShimmer(
                    height: 120.0,
                    width: (MediaQuery.of(context).size.width - 32) / 3)),
            Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ShimmerHelper().buildBasicShimmer(
                    height: 120.0,
                    width: (MediaQuery.of(context).size.width - 32) / 3)),
          ],
        ),
      );
    } else if (_featuredCategoryList.isNotEmpty) {
      //snapshot.hasData
      return Padding(
        padding: const EdgeInsets.only(
          right: 12,
          left: 12
        ),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemExtent: 140,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return CategoryDetais(homCatTabedInd: index,fromHome: true,);
                    }));
                  },
                  child: SizedBox(
                    height: 250,
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          ///57
                          width: 100,
//                          decoration: BoxDecoration(
//                              shape: BoxShape.circle,
//                              border:
//                                  Border.all(color: Colors.amber, width: 2.8)),
                              child:
                              //'assets/placeholder.png'
                              _featuredCategoryList[index].catImg!.isEmpty
                                  ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                width: 100,
                                height: 100,
                                    child: Image.asset(
                                      'assets/1.jpg',
//                                        fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  )
                                  : Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.network(
                                      'https://alhasnaa.site/files/' +
                                          _featuredCategoryList[index]
                                              .catImg!, /////
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              catName(index),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
          } else if (!_isCategoryInitial && _featuredCategoryList.isEmpty) {
      return SizedBox(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context)!.home_screen_no_category_found,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }


  String catName(int index) {
    if (app_mobile_language.$ == 'en') {
      return _featuredCategoryList[index].catNameEn!;
    } else if (app_language.$ == 'ar') {
      return _featuredCategoryList[index].catNameAr!;
    } else {
      return _featuredCategoryList[index].catNameTr!;
    }
  }
}
