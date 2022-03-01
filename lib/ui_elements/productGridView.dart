import 'package:elhasnaa/data_model/get_Country_product.dart';
import 'package:elhasnaa/data_model/products.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/helpers/shimmer_helper.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/repositories/getCatOffers.dart';
import 'package:elhasnaa/screens/product_details.dart';
import 'package:flutter/material.dart';


class ProductGridView extends StatelessWidget {

  List<getCountryProduct> cats = [];

  onClick(context,index){
    getCountryProduct _getCat = cats[index];

    List<String> brandImg = [_getCat.prodImg!];

    Products cat = Products(id:_getCat.prodId ,prodPrice:_getCat.prodPrice ,prodNo:_getCat.prodNo ,
        prodImg:_getCat.prodImg ,prodNameAr:_getCat.prodNameAr ,prodNameEn:_getCat.prodNameEn ,
        prodNameTr:_getCat.prodNameTr,brandId:_getCat.brandId ,prodDescAr:_getCat.prodDescAr ,
        prodDescEn:_getCat.prodDescEn ,prodDescTr:_getCat.prodDescTr ,isOffer:_getCat.isOffer,
        brandNameAr:_getCat.brandNameAr ,brandNameEn:_getCat.brandNameEn ,
        brandNameTr:_getCat.brandNameTr, images:brandImg);
    print('salllllllem');

    Navigator.push(context, MaterialPageRoute(
        builder: (context)=>ProductDetails(
            product:cat
        )));
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:GetOffersCategories().fetchOffersCat(country_id.$),
      builder: (context,s){
             cats = s.data as List<getCountryProduct>;
       if(s.hasData){
          return Container(
            padding: EdgeInsets.all(5),
            width: double.infinity,
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cats.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3.0,
                    crossAxisSpacing: 3.0
                ),
                itemBuilder: (context,i){
                print('iiiiiiiii:${i}');
                print('llllllllenght:${cats.length}');
                  return InkWell(
                    onTap: (){
                      onClick(context,i);
                    },
                    child: Card(
                      elevation: 3.0,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: MyTheme.white
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: cats[i].prodImg! == ""?Image.asset('assets/1.jpg')
                                  :Image.network('https://alhasnaa.site/files/'+cats[i].prodImg!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            Text(cats[i].prodNameAr!,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                                color: Colors.grey,
                              ),),
                            Text('${cats[i].prodPrice!} س.ر',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        }else if(!s.hasData){
         return ShimmerHelper().buildProductGridShimmer();
        }else {
          return ShimmerHelper().buildProductGridShimmer();
        }
      },
    );
  }
}
