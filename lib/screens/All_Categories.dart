import 'package:elhasnaa/data_model/category_response.dart';
import 'package:elhasnaa/repositories/category_repository.dart';
import 'package:elhasnaa/ui_elements/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'category_details.dart';




class AllCategories extends StatelessWidget {
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
        title:  Text(AppLocalizations.of(context)!.home_screen_featured_categories,style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
          future: CategoryRepository().getFeturedCategories(),
          builder: (context,s){
            List<Categories>? cats = s.data as List<Categories>?;
            if(s.hasData){
              return GridView.builder(
//                scrollDirection: Axis.vertical,
                  physics:NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cats!.length,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return CategoryDetais(homCatTabedInd: i,fromHome: true,);
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8,
                            right: 8
                        ),
                        child: Column(
                            children: <Widget>[
                              SizedBox(height: 5),
                              cats[i].catImg == "" ?Image.asset('assets/1.jpg'): Image.network(
                                'https://alhasnaa.site/files/' + cats[i].catImg!,
                                height: 180,
                              ),
                              SizedBox(height: 0.0),
                              Text(
                                cats[i].catNameAr.toString(),
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
