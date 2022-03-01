import 'package:elhasnaa/data_model/country.dart';
import 'package:elhasnaa/repositories/getCountryCat.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChosesCountry extends StatefulWidget {
  const ChosesCountry({Key? key}) : super(key: key);

  @override
  State<ChosesCountry> createState() => _ChosesCountryState();
}

class _ChosesCountryState extends State<ChosesCountry> {
  Country dropdownValue = Country(id: '0', countryName: 'Select Country');

  // ignore: non_constant_identifier_names,

  late final Future<List<Country>> fetchData;

  @override
  void initState() {
    // TODO: implement initState
    fetchData = fetchCountryCat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('dropDown : ${dropdownValue.toString()}');
    return Scaffold(
      body: FutureBuilder<List<Country>>(
        future: fetchData,
        builder: (c, s) {
          if (s.hasData) {
            return Center(
              child: Container(
                width: 160,
                height: 50,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3, right: 6),
                  child: DropdownButton<Country>(
                    elevation: 20,
                    iconSize: 30,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                    ),
                    items: [
                      DropdownMenuItem(
                         value:dropdownValue,
                          enabled: false, child: Text(dropdownValue.countryName!)),
                      ...s.data!.map((Country country) {
                        return DropdownMenuItem<Country>(
                          value: country,
                          child: Container(
                            height: 50,
                            width: 120,
                            child: Card(
                              elevation: 8.0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                        'https://alhasnaa.site/files/' +
                                            country.flag!),
                                    SizedBox(width: 25),
                                    Text(country.countryName!.toString())
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList()
                    ],
                    value: dropdownValue,
                    onChanged: (val) {
                       dropdownValue = val!;
                       print('####:${dropdownValue.countryName}');
                       },
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );

  }
}


