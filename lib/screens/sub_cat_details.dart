import 'package:elhasnaa/data_model/category_response.dart';
import 'package:elhasnaa/data_model/products.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/helpers/shimmer_helper.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/repositories/get_sub_cat.dart';
import 'package:elhasnaa/repositories/products_response.dart';
import 'package:elhasnaa/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubCatgDetailsScreen extends StatefulWidget {
  SubCatgDetailsScreen({Key? key, this.catgsId, required this.navFrom})
      : super(key: key);
  String? catgsId;
  bool navFrom=false;

  @override
  _SubCatgDetailsScreenState createState() => _SubCatgDetailsScreenState();
}

class _SubCatgDetailsScreenState extends State<SubCatgDetailsScreen> {
  final List<Products> _ProductsList = [];
  final List<Categories> _subSubCateg = [];

  //int? _tabedCatIndex = 0;
  // bool _isCategoryInitial = true;

  fetchSubProducts() async {
    if(widget.navFrom){
      print('all datat if stat');
      print(widget.navFrom);
      var productsResponse =
      await ProductsResponse().fetchProducts(widget.catgsId!);//
      _ProductsList.addAll(productsResponse);
    }else{
      print('subb datat if stat');
      var productsResponse =
      await ProductsResponse().fetchProducts(widget.catgsId!);//
      _ProductsList.addAll(productsResponse);
    }

    setState(() {});
  }

  fetchSubCategories() async {
    // print('fetch Subcategories ksksdkd');
    _subSubCateg.clear();
    if (widget.catgsId!.isNotEmpty) {
      var categoryResponse =
      await GetSubCategories().fetchOneCat(widget.catgsId!);
      _subSubCateg.addAll(categoryResponse!);
      // print("--------------cat details---------------- ");
      //print(_subCategoriesList);
      //_isCategoryInitial = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  fetchAll() async {
    await fetchSubProducts();
    // await fetchSubCategories();
  }

  @override
  void initState() {
    super.initState();
    // In initState()
    fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(statusBarHeight, context),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [

                // Text('${widget.catgName}',style: const TextStyle(
                //   fontSize: 18,
                //   fontWeight: FontWeight.bold),
                //   ),
                //buildSubCategsList(context),
                buildProductsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget buildAppBar(double statusBarHeight, BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: SizedBox(
  //       height: kToolbarHeight +
  //           statusBarHeight -
  //           (MediaQuery.of(context).viewPadding.top > 40 ? 16.0 : 16.0),
  //       //MediaQuery.of(context).viewPadding.top is the statusbar height, with a notch phone it results almost 50, without a notch it shows 24.0.For safety we have checked if its greater than thirty
  //       child: Container(
  //         width: double.infinity,
  //         child: Padding(
  //             padding: app_language_rtl.$
  //                 ? const EdgeInsets.only(top: 14.0, bottom: 14, left: 12)
  //                 : const EdgeInsets.only(top: 14.0, bottom: 14, right: 12),
  //             // when notification bell will be shown , the right padding will cease to exist.
  //             child: GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(context,
  //                       MaterialPageRoute(builder: (context) {
  //                     return const Scaffold(); //Filter();
  //                   }));
  //                 },
  //                 child: buildHomeSearchBox(context))),
  //       ),
  //     ),
  //   );
  // }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) =>  IconButton(
            icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
            onPressed: () => Navigator.of(context).pop(),
          )
          ,
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

  buildSubCategsList(context) {
    if (_subSubCateg.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ShimmerHelper().buildListShimmer(
                  item_count: 3,
                  item_height: MediaQuery.of(context).size.height * 0.2)),
        ],
      );
    } else if (_subSubCateg.isNotEmpty) {
      return Expanded(
        child: ListView.builder(
            itemCount: _subSubCateg.length,
            itemBuilder: (context, index) {
              if (_subSubCateg.isEmpty) {
                return const CircularProgressIndicator(
                  color: Colors.grey,
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _subSubCateg[index].catNameAr!,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        /////////future builder
                        buildProductsList(),
                      ],
                    ),
                  ),
                );
              }
            }),
      );
    }
  }

  Widget buildProductsList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio:2 / 3,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _ProductsList.length,
      itemBuilder: (ctx, index) {
        print(_ProductsList[index].images);
        return buildProductTile(_ProductsList[index]);
      },
    );
  }

  buildProductTile( Products currPro){
    print('current prooo ${currPro.images}');
    return Container(
      width: double.infinity,
      //margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return ProductDetails(product: currPro,);
          }));
        },//todo navigate to product details
        child: GridTile(
          child: Hero(
            tag: currPro.id!,
            child: Container(
              // width: double.infinity,
              // height: double.infinity,
              color: const Color.fromARGB(52, 58, 64,1),
              child: currPro.prodImg!.isNotEmpty
                  ? FadeInImage.assetNetwork(
                width: double.infinity,
                height: double.infinity,
                placeholder: 'assets/placeholder.png',
                image: 'https://alhasnaa.site/files/' +currPro.prodImg!,
                fit: BoxFit.cover,
              )
                  : Image.asset('assets/placeholder.png',
                //fit:BoxFit.contain,

              ),
            ),
          ),
          footer: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              alignment: Alignment.bottomCenter,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${currPro.prodNameAr}', //todo prod descrip
                    style: const TextStyle(
                      height: 0.7,
                      fontSize: 10,
                      color: Colors.grey,
                      // fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:3),
                    child: Row(
                      children: [
                        Text(
                          '${currPro.prodPrice}',
                          style: const TextStyle(
                            height: 1.0,
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                        ),

                        const SizedBox(width: 5,),
                        const Text(
                          'Try', //todo localiz
                          style: TextStyle(
                            height: 0.7,
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          //textAlign: TextAlign.center,
                        ),

                      ],
                    ),
                  )

                ],
              )     ),
        ),
      ),
    );

  }


// buildProductsList(index, context) {
//   return FutureBuilder<List<Products>?>(
//     future: ProductsResponse()
//         .fetchCountrySubSubCP(_subSubCateg[index].id, "1"), //TODO country id
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return ShimmerHelper()
//             .buildProductShimmer(); //CircularProgressIndicator();

//       } else if (snapshot.connectionState == ConnectionState.done) {
//         if (snapshot.hasError) {
//           return const Text('Error');
//         } else if (snapshot.hasData) {

//             return GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                   childAspectRatio: 2 / 3,
//                   crossAxisSpacing: 1,
//                   mainAxisSpacing: 1,
//                 ),
//                 physics: const ClampingScrollPhysics(),
//                 shrinkWrap: true,
//                 padding: EdgeInsets.zero,
//                 itemCount: snapshot.data!.length,
//                 //scrollDirection: Axis.horizontal,
//                 itemBuilder: (BuildContext ctx, i) {
//                    print('error ${snapshot.data![i].id!}');
//                   if(snapshot.data![i].id!.isEmpty) {
//                     return const Text('No products during this time');
//                   } else{
//                     return InkWell(
//                       onTap: () {
//                         print(snapshot.data![i].id);

//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProductDetails(
//                               product: snapshot.data![i],
//                             ),
//                           ),
//                         );
//                       },
//                       child: Column(
//                         children: [
//                           Container(
//                             height: MediaQuery.of(context).size.width * 0.2,
//                             width: MediaQuery.of(context).size.width * 0.2,
//                             color: Colors.grey,
//                             child: snapshot.data![i].prodImg!.isNotEmpty
//                                 ? Image.network(
//                                     'https://alhasnaa.site/files/' +
//                                         snapshot.data![i].prodImg!, /////
//                                     fit: BoxFit.cover,
//                                     width: double.infinity,
//                                   )
//                                 : Image.asset(
//                                     'assets/1.jpg',
//                                     fit: BoxFit.cover,
//                                     width: double.infinity,
//                                   ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 2),
//                             child: Container(
//                               alignment: Alignment.center,
//                               width: 60,
//                               child: SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.width * 0.1,
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.2,
//                                 child: Text(
//                                   snapshot.data![i].prodNameAr!,
//                                   // prodName(snapshot[i]),
//                                   maxLines: 3,
//                                   overflow: TextOverflow.ellipsis,
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );

//                   }
//                 });

//         } else {
//           return const Text('Empty data');
//         }
//       } else {
//         return Text('State: ${snapshot.connectionState}');
//       }
//     },
//   );
// }


}