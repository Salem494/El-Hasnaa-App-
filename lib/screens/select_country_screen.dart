import 'package:elhasnaa/data_model/country.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/provider/locale_provider.dart';
import 'package:elhasnaa/repositories/getCountryCat.dart';
import 'package:elhasnaa/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({Key? key}) : super(key: key);

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  List<Country> countryList = [];

  getCountryList() async {
    List<Country> countryResponse = await CountryRepo().fetchCountryCat();
    countryList.addAll(countryResponse);
  }

  fetchData() {
    getCountryList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          showBottomSheet();
        },
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: 50,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: MyTheme.golden,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Row(
                children: [
                  Text(
                    'Select Your Current Country',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showBottomSheet() {
    return showModalBottomSheet(
        enableDrag: false,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
        context: context,
        builder: (context) {
          return countryList.isEmpty
              ? CircularProgressIndicator(
                  color: MyTheme.light_grey,
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: countryList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            country_id.$ = countryList[index].id!;
                            country_id.save();
                            app_language.$ = countryList[index].catNameAr!;
                            app_language.save();
                            app_mobile_language.$ = countryList[index].lang!;
                            app_mobile_language.save();
                            if (countryList[index].lang == 'ar') {
                              app_language_rtl.$ = true;
                              app_language_rtl.save();
                            } else {
                              app_language_rtl.$ = false;
                              app_language_rtl.save();
                            }

                            Provider.of<LocaleProvider>(context, listen: false)
                                .setLocale(countryList[index].lang!);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Main()),
                            );
                          },
                          child: ListTile(
                            leading: SizedBox(
                              height: 20,
                              width: 25,
                              child: FadeInImage.assetNetwork(
                                placeholder:
                                    'assets/1.jpg', //todo git img url from api
                                image: 'https://alhasnaa.site/files/' +
                                    countryList[index].flag!,
                                fit: BoxFit.fill,
                              ),
                            ),
                            title: Text(countryList[index].countryNameEn!),
                          ),
                        ),
                        Divider(
                          color: MyTheme.dark_grey,
                          height: 1,
                        ),
                      ],
                    );
                  });
        });
  }
}
