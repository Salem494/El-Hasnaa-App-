import 'package:elhasnaa/data_model/sliderModel.dart';
import 'package:elhasnaa/repositories/get_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BuildSlider extends StatefulWidget {
  @override
  _BuildSliderState createState() => _BuildSliderState();
}

 List<String> images = [
   'dummy_assets/slider_1.png',
   'dummy_assets/slider_2.png',
   'dummy_assets/slider_3.png',
 ];



class _BuildSliderState extends State<BuildSlider> {
late final List<SliderModel> slide = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchSlider(),
      builder: (c,s){
        final List<SliderModel> sliders = s.data as List<SliderModel>;
        if(s.hasData){
        return Container(
          width: double.infinity,
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: sliders.length,
              itemBuilder: (context,i){
            return CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 2.67,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.easeInCubic,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: sliders.map((e){
                  return Image.network('https://alhasnaa.site/files/' + e.sliderPhoto.toString(),
                  width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }).toList());
          }),
        );
      }else if(!s.hasData){
        return Center(child: Text('No Data Request'),);
      } else {
        return Center(child: CircularProgressIndicator(),);
      }
      },
    );
  }
}
