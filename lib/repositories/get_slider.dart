import 'dart:convert';
import 'package:elhasnaa/data_model/sliderModel.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<List<SliderModel>?> fetchSlider() async {
  String url = 'https://alhasnaa.site/api/slider.php';
  Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    //print('Susssssssesssss');
    var body = jsonDecode(response.body);
    List<SliderModel> slider = [];
    for(var slide in body){
      slider.add(SliderModel.fromJson(slide));
    }
    print('slider:${slider[0].sliderPhoto}');
    return slider;
  } else {
    //print(response.statusCode);
  }
}