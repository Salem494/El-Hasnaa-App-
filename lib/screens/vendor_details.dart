import 'package:elhasnaa/data_model/get_vendors.dart';
import 'package:elhasnaa/data_model/products.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/helpers/shimmer_helper.dart';
import 'package:elhasnaa/repositories/get_Vendor.dart';
import 'package:elhasnaa/screens/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../my_theme.dart';

class VendorDetails extends StatefulWidget {
   getVendors vendor =getVendors();
  VendorDetails({required this.vendor});

  @override
  State<VendorDetails> createState() => _VendorDetailsState();
}

class _VendorDetailsState extends State<VendorDetails> {
  List<getVendors> _vendors = [];

   onClick(context,index){
     getVendors _getVen = _vendors[index];

     List<String> brandImg = [_getVen.prodImg!];

     Products vendor = Products(id:_getVen.prodId ,prodPrice:_getVen.prodPrice ,prodNo:_getVen.prodNo ,
         prodImg:_getVen.prodImg ,prodNameAr:_getVen.prodNameAr ,prodNameEn:_getVen.prodNameEn ,
         prodNameTr:_getVen.prodNameTr,brandId:_getVen.brandId ,prodDescAr:_getVen.prodDescAr ,
         prodDescEn:_getVen.prodDescEn ,prodDescTr:_getVen.prodDescTr ,isOffer:_getVen.isOffer,
         brandNameAr:_getVen.brandNameAr ,brandNameEn:_getVen.brandNameEn ,
         brandNameTr:_getVen.brandNameTr, images:brandImg);
     print('salllllllem');

     Navigator.push(context, MaterialPageRoute(
         builder: (context)=>ProductDetails(
             product:vendor
         )));
   }


    @override
    Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.black,)),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title:  Text(AppLocalizations.of(context)!.one_vendor,style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            widget.vendor.banner! == "" ?Padding(
              padding: const EdgeInsets.all(5.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 200.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3),
            ):Image.network(
              'https://alhasnaa.site/files/' + widget.vendor.banner!,
              height: 180,
              width: double.infinity,
            ),
            Text(widget.vendor.vendorName!,style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 15,),
            Container(
              child: Center(
                child: widget.vendor.aboutVendor! ==  "" ? Text("No Data Founded",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),): Text(widget.vendor.aboutVendor!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),),
              ),
              decoration: BoxDecoration(
                color:Colors.white,
              ),
              height: 180,
              width: double.infinity,
            ),
            SizedBox(height: 12,),
            Text(" Last Data Added  : " " ${widget.vendor.addDate!}",style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 15,),
            FutureBuilder(
             future:fetchOneVendor(country_id.$,vendor_id.$),
             builder: (c,s){
               _vendors = s.data as List<getVendors>;
               print('vendors.length :${_vendors.length}');
               if(s.hasData){
                 return Padding(
                   padding: const EdgeInsets.only(
                     left: 15,
                     right: 15
                   ),
                   child: Container(
                     padding: EdgeInsets.all(5),
                     width: double.infinity,
                     child: GridView.builder(
                         shrinkWrap: true,
                         physics: NeverScrollableScrollPhysics(),
                         itemCount: _vendors.length,
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                             crossAxisCount: 2,
                             mainAxisSpacing: 3.0,
                             crossAxisSpacing: 3.0
                         ),
                         itemBuilder: (context,i){
                           print('llllllllenghtSallllem:${_vendors.length}');
                           print('llllllllenghtSallllemiiiiiii:${i}');
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
                                       child: _vendors[i].prodImg! == ""?Image.asset('assets/1.jpg')
                                           :Image.network('https://alhasnaa.site/files/'+_vendors[i].prodImg!,
                                         fit: BoxFit.cover,
                                         width: double.infinity,
                                         height: double.infinity,
                                       ),
                                     ),
                                     Text(_vendors[i].prodNameAr!,
                                       style: TextStyle(
                                         fontWeight: FontWeight.w300,
                                         fontSize: 20,
                                         color: Colors.grey,
                                       ),),
                                     Text('${_vendors[i].prodPrice!} س.ر',
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
                   ),
                 );
               }else if(!s.hasData){
                 return ShimmerHelper().buildProductGridShimmer();
               }else {
                 return ShimmerHelper().buildProductGridShimmer();
               }

             },
           )
          ],
        ),
      ),
    );
  }
}
