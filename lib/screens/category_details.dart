import 'package:elhasnaa/data_model/category_response.dart';
import 'package:elhasnaa/data_model/products.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/helpers/shimmer_helper.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/repositories/category_repository.dart';
import 'package:elhasnaa/repositories/get_sub_cat.dart';
import 'package:elhasnaa/repositories/products_response.dart';
import 'package:elhasnaa/screens/sub_cat_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryDetais extends StatefulWidget {
  CategoryDetais({Key? key, this.homCatTabedInd = 0, this.fromHome = false})
      : super(key: key);
  int? homCatTabedInd;
  bool? fromHome;

  @override
  _CategoryDetaisState createState() => _CategoryDetaisState();
}

class _CategoryDetaisState extends State<CategoryDetais> {
  final List<Categories> _featuredCategoryList = [];
  final List<Categories> _subCategoriesList = [];
  int? _tabedCatIndex = 0;
  // bool _isCategoryInitial = true;

  fetchFeaturedCategories() async {
    // print('fetch categories ksksdkd');
    var categoryResponse = await CategoryRepository().getFeturedCategories();
    _featuredCategoryList.addAll(categoryResponse);
    // print("homeeee fetch featured categ ---------------- ");
    // print(_featuredCategoryList);
    //_isCategoryInitial = false;
    setState(() {});
  }

  fetchSubCategories() async {
    // print('fetch Subcategories ksksdkd');
    _subCategoriesList.clear();
    if (_featuredCategoryList.isNotEmpty) {
      var categoryResponse = await GetSubCategories()
          .fetchOneCat(_featuredCategoryList[_tabedCatIndex!].id!);
      _subCategoriesList.addAll(categoryResponse!);
      // print("--------------cat details---------------- ");
      //print(_subCategoriesList);
      //_isCategoryInitial = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  setTabindex() {
    print('you aaaare in details page index = ${widget.homCatTabedInd}');
    _tabedCatIndex = widget.homCatTabedInd;
    setState(() {
      if (widget.homCatTabedInd!.isNaN) {
        print('you are in details page index = ${widget.homCatTabedInd}');
      }
    });
  }

  fetchAll() async {
    await fetchFeaturedCategories();
    await fetchSubCategories();
  }

  @override
  void initState() {
    super.initState();
    // In initState()
    fetchAll();
    setTabindex();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(statusBarHeight,context),
        body:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              buildLeftPanel(),
              buildBody(),
            ],
          ),
        ),

      ),
    );
  }

  // AppBar buildAppBar(BuildContext context) {
  //   return AppBar(
  //     backgroundColor: Colors.white,
  //     centerTitle: true,
  //     leading: Builder(
  //       builder: (context) => (widget.fromHome!)
  //           ? IconButton(
  //               icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
  //               onPressed: () => Navigator.of(context).pop(),
  //             )
  //           : Container(),
  //     ),
  //     title: Text(
  //       AppLocalizations.of(context)!.categories_appbar_title, ///////////////
  //       style: TextStyle(fontSize: 16, color: MyTheme.accent_color),
  //     ),
  //     elevation: 0.0,
  //     titleSpacing: 0,
  //   );
  // }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => (widget.fromHome!)
              ? IconButton(
            icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
            onPressed: () => Navigator.of(context).pop(),
          )
              : Container(),
        ),

        title: SizedBox(
          width:double.infinity,
          height: kToolbarHeight +
              statusBarHeight -
              (MediaQuery.of(context).viewPadding.top > 40 ? 16.0 : 16.0),
          //MediaQuery.of(context).viewPadding.top is the statusbar height, with a notch phone it results almost 50, without a notch it shows 24.0.For safety we have checked if its greater than thirty
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
        elevation: 0.0,
        titleSpacing: 0
    );
  }
  // Widget buildAppBar(double statusBarHeight, BuildContext context) {
  //   return Expanded(
  //     child: Row(
  //       children: [
  //         Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 8),
  //       child: SizedBox(
  //         height: kToolbarHeight +
  //             statusBarHeight -
  //             (MediaQuery.of(context).viewPadding.top > 40 ? 16.0 : 16.0),
  //         //MediaQuery.of(context).viewPadding.top is the statusbar height, with a notch phone it results almost 50, without a notch it shows 24.0.For safety we have checked if its greater than thirty
  //         child: Container(
  //           width: double.infinity,
  //           child: Padding(
  //               padding: app_language_rtl.$
  //                   ? const EdgeInsets.only(top: 14.0, bottom: 14, left: 12)
  //                   : const EdgeInsets.only(top: 14.0, bottom: 14, right: 12),
  //               // when notification bell will be shown , the right padding will cease to exist.
  //               child: GestureDetector(
  //                   onTap: () {
  //                     Navigator.push(context,
  //                         MaterialPageRoute(builder: (context) {
  //                       return const Scaffold(); //Filter();
  //                     }));
  //                   },
  //                   child: buildHomeSearchBox(context))),
  //         ),
  //       ),
  //     ),

  //       ],
  //     ),
  //   );
  //    }


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

  buildLeftPanel(){
    return  Padding(
      padding:app_language_rtl.$
          ? const EdgeInsets.only(left: 5)
          : const EdgeInsets.only(right: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.grey[200], //todo change grey degree
        ),
        width: MediaQuery.of(context).size.width * 0.24,
        //height: MediaQuery.of(context).size.height*0.8,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _featuredCategoryList.length,
                  //shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _tabedCatIndex = index;
                          // _subCategoriesList;
                        });
                        fetchSubCategories();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: _tabedCatIndex == index
                              ? Colors.white
                              : Colors.grey[
                          200], //todo change grey degree
                        ),
                        alignment: Alignment.center,
                        width:
                        MediaQuery.of(context).size.width * 0.3,
                        height: 50,
                        child: Text(
                          catName(index),
                          // _featuredCategoryList[index].catNameAr!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );

  }

  buildBody(){
    return   Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              //width: MediaQuery.of(context).size.width*0.6,
              //height: 200,
              child: (_featuredCategoryList.isEmpty)
                  ? Column(
                children: [
                  Padding(
                      padding:
                      const EdgeInsets.only(right: 8.0),
                      child: ShimmerHelper()
                          .buildBasicShimmer(
                          height: MediaQuery.of(context)
                              .size
                              .width *
                              0.28,
                          width: MediaQuery.of(context)
                              .size
                              .width *
                              0.28)),
                ],
              )
                  : ListView.builder(
                  itemCount: _subCategoriesList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                print(
                                    'caaaaaaaaaaaaaat index ${_subCategoriesList[index].id}');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SubCatgDetailsScreen(
                                          catgsId:_subCategoriesList[index].id,
                                          navFrom:true
                                          ,
                                        ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    _subCategoriesList[index]
                                        .catNameAr!,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        "All",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons
                                            .arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            /////////future builder
                            buildProductsList(index, context),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );

  }

  buildProductsList(index, context) {
    return FutureBuilder<List<Categories>?>(
      future: GetSubCategories().fetchOneCat(_subCategoriesList[index].id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerHelper()
              .buildProductShimmer(); //CircularProgressIndicator();

        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2/ 3,
                  crossAxisSpacing: 0.5,
                  mainAxisSpacing: 1,
                ),
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: snapshot.data!.length,
                //scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext ctx, i) {
                  return InkWell(
                    onTap: () {
                      print(snapshot.data![i].id);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubCatgDetailsScreen(navFrom:false,catgsId: snapshot.data![i].id,)
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                          color: Colors.grey,
                          child: snapshot.data![i].catImg!.isNotEmpty
                              ? Image.network(
                            'https://alhasnaa.site/files/' +
                                snapshot.data![i].catImg!, /////
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                              : Image.asset(
                            'assets/1.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Container(
                            alignment: Alignment.center,
                            width: 60,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.width * 0.1,
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                snapshot.data![i].catNameAr!, //todo catlang
                                // prodName(snapshot[i]),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }

  buildCustomProduct(List<Products>? snapshot, context) {
    var lstLength = snapshot!.length;
    print('snapshot length ${lstLength}');
    //print(snapshot!.length);
    ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: lstLength,
        itemBuilder: (context, i) {
          print('in functioooooooooooooooooooooooooooooon tesssst');
          print(snapshot[i].id);
          return Text("${snapshot[i].prodNameAr}");
          //  InkWell(
          //   onTap: () {
          //     ProductDetails(
          //       product: snapshot[i],
          //     );
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          //     child: Column(
          //       children: [
          //         Container(
          //           height: MediaQuery.of(context).size.width * 0.2,
          //           width: MediaQuery.of(context).size.width * 0.2,
          //           color: Colors.grey,
          //           // child: snapshot[i].prodImg!.isNotEmpty
          //           //     ? Image.network(
          //           //         'https://alhasnaa.site/files/' +
          //           //             snapshot[i].prodImg!, /////
          //           //         fit: BoxFit.cover,
          //           //         width: double.infinity,
          //           //       )
          //           //     : Image.asset(
          //           //         'assets/placeholder.png',
          //           //         fit: BoxFit.cover,
          //           //         width: double.infinity,
          //           //       ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.symmetric(vertical: 2),
          //           child: Container(
          //             alignment: Alignment.center,
          //             width: 60,
          //             child: Text(
          //               snapshot[i].prodNameAr! + 'test',
          //               // prodName(snapshot[i]),
          //               maxLines: 3,
          //               textAlign: TextAlign.center,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // );
        });
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

  String prodName(lst) {
    if (app_mobile_language.$ == 'en') {
      return lst.prodNameEn!;
    } else if (app_language.$ == 'ar') {
      return lst.prodNameAr!;
    } else {
      return lst.prodNameTr!;
    }
  }
}




//  ListView.builder(
//       shrinkWrap: true,
//       scrollDirection: Axis.horizontal,
//       itemCount:snapshot.data!.length,
//       itemBuilder: (context, i) {
//         return
//          InkWell(
//           onTap: () {
//             ProductDetails(
//               product: snapshot.data![i],
//             );
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//             child: Column(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.width * 0.2,
//                   width: MediaQuery.of(context).size.width * 0.2,
//                   color: Colors.grey,
//                   // child: snapshot[i].prodImg!.isNotEmpty
//                   //     ? Image.network(
//                   //         'https://alhasnaa.site/files/' +
//                   //             snapshot[i].prodImg!, /////
//                   //         fit: BoxFit.cover,
//                   //         width: double.infinity,
//                   //       )
//                   //     : Image.asset(
//                   //         'assets/placeholder.png',
//                   //         fit: BoxFit.cover,
//                   //         width: double.infinity,
//                   //       ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 2),
//                   child: Container(
//                     alignment: Alignment.center,
//                     width: 60,
//                     child: SizedBox(
//                       height: MediaQuery.of(context).size.width * 0.1,
//                       width: MediaQuery.of(context).size.width * 0.2,
//                       child: Text(
//                         snapshot.data![i].prodNameAr!,
//                         // prodName(snapshot[i]),
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );

//       }),





// buildMainCategsList(context) {
//   if (_featuredCategoryList.isEmpty) {
//     return Column(
//       children: [
//         Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: ShimmerHelper().buildBasicShimmer(
//                 height: MediaQuery.of(context).size.width * 0.28,
//                 width: MediaQuery.of(context).size.width * 0.28)),
//       ],
//     );
//   } else if (_featuredCategoryList.isNotEmpty) {
//     return ListView.builder(
//         itemCount: _subCategoriesList.length,
//         itemBuilder: (context, index) {
//           if (_subCategoriesList.isEmpty) {
//             return const CircularProgressIndicator(
//               color: Colors.grey,
//             );
//           } else {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       _subCategoriesList[index].catNameAr!,
//                       style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     /////////future builder
//                     buildProductsList(index, context),
//                   ],
//                 ),
//               ),
//             );
//           }
//         });
//   }
// }