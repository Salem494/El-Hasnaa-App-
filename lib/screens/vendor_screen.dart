import 'package:elhasnaa/repositories/get_All_Vendors.dart';
import 'package:elhasnaa/repositories/get_Vendor.dart';
import 'package:elhasnaa/screens/vendor_details.dart';
import 'package:elhasnaa/ui_elements/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:elhasnaa/data_model/get_vendors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';



class VendorScreen extends StatefulWidget {
  @override
  _VendorScreenState createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
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
          title:  Text(AppLocalizations.of(context)!.all_vendors,style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
        ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
          future: fetchVendors(),
          builder: (context,s){
            List<getVendors>? vendors = s.data as List<getVendors>?;
//             List<getVendors>? vendors = s.data as List<getVendors>?;
            if(s.hasData){
              return GridView.builder(
//                scrollDirection: Axis.vertical,
                   physics:NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  itemCount: vendors!.length,
                  // ignore: prefer_const_constructors
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 8/9,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      crossAxisCount: 2,
              ),
                  itemBuilder: (c,i) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>
                            VendorDetails(
                           vendor: vendors[i],
                        )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8
                        ),
                        child: Column(
                            children: <Widget>[
                                SizedBox(height: 5),
                              vendors[i].logo == "" ?Image.asset('assets/1.jpg'): Image.network(
                                'https://alhasnaa.site/files/' + vendors[i].logo!,
                                height: 180,
                              ),
                              SizedBox(height: 0.0),
                              Text(
                                vendors[i].vendorName.toString(),
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
