import 'package:elhasnaa/data_model/brands.dart';
import 'package:elhasnaa/data_model/products.dart';
import 'package:elhasnaa/repositories/getBrands.dart';
import 'package:elhasnaa/screens/product_details.dart';
import 'package:elhasnaa/screens/profile.dart';
import 'package:elhasnaa/ui_elements/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




class AllBrands extends StatelessWidget {


  onClick(context,index){
    List<Brands> _brands = [];

    Brands brands = _brands[index];

    List<String> brandImg = [brands.prodImg!];

    Products brand = Products(id:brands.prodId ,prodPrice:brands.prodPrice ,prodNo:brands.prodNo ,
        prodImg:brands.prodImg ,prodNameAr:brands.prodNameAr ,prodNameEn:brands.prodNameEn ,
        prodNameTr:brands.prodNameTr,brandId:brands.brandId ,prodDescAr:brands.prodDescAr ,
        prodDescEn:brands.prodDescEn ,prodDescTr:brands.prodDescTr ,isOffer:brands.isOffer,
        brandNameAr:brands.brandNameAr ,brandNameEn:brands.brandNameEn ,
        brandNameTr:brands.brandNameTr, images:brandImg);
    print('salllllllem');

    Navigator.push(context, MaterialPageRoute(
        builder: (context)=>ProductDetails(
            product:brand
        )));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.black,)),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title:  Text(AppLocalizations.of(context)!.brand,style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
          future:BrandsRepo().fetchBrands(),
          builder: (context,s){
            List<Brands>? Brand = s.data as List<Brands>?;
            if(s.hasData){
              return GridView.builder(
//                scrollDirection: Axis.vertical,
                  physics:NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Brand!.length,
                  // ignore: prefer_const_constructors
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 8/9,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (c,i) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 8,
                          right: 8
                      ),
                      child: InkWell(
                          onTap:(){
                            print('salem');
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                          },
                        child: Column(
                            children: <Widget>[
                              SizedBox(height: 5),
                              Brand[i].catImg == "" ?Image.asset('assets/1.jpg'): Image.network(
                                'https://alhasnaa.site/files/' + Brand[i].catImg!,
                                height: 180,
                              ),
                              SizedBox(height: 0.0),
                              Text(
                                  Brand[i].catNameAr.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,
                                    color: Colors.black),
                              ),
                            ]),
                      ),
                    );
                  });
            }
            else if(!s.hasData){
              return ShimmerWidget();
            }else {
              return Text('No Data Request!');
            }
          },
        ),
      ),
    );

  }
}
