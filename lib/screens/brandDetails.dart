import 'package:elhasnaa/data_model/brands.dart';
import 'package:elhasnaa/data_model/products.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/repositories/getBrands.dart';
import 'package:elhasnaa/screens/product_details.dart';
import 'package:flutter/material.dart';

import '../my_theme.dart';


class BrandDetails extends StatelessWidget {

    final Brands brands;
    BrandDetails({required this.brands});

    List<Brands> _brands = [];

    onClick(context,index){
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
    print('salem :${BrandsRepo().fetchBrandDetails("1","100000")}');
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
        title:  Text(brands.catNameAr!,style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: BrandsRepo().fetchBrandDetails(country_id.$,'100000'),
          builder:(c,s){
            if(s.hasData){
              _brands = s.data as List<Brands>;
              return Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                    shrinkWrap: true,
//                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _brands.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 3.0,
                        crossAxisSpacing: 3.0
                    ),
                    itemBuilder: (context,i){
                      return InkWell(
                        onTap: (){
                          print(_brands.length);
                          print("iiii : ${i}");
                         onClick(context, i);
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
                                  child: _brands[i].prodImg! == ""?Image.asset('assets/1.jpg')
                                      :Image.network('https://alhasnaa.site/files/'+_brands[i].prodImg!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                                Text(_brands[i].prodNameAr!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),),
                                Text('${_brands[i].prodPrice!} س.ر',
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
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      )
    );
  }
}
