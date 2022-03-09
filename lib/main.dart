import 'package:elhasnaa/app_config.dart';
import 'package:elhasnaa/data_model/products.dart';
import 'package:elhasnaa/helpers/shared_value_helper.dart';
import 'package:elhasnaa/lang_config.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/provider/alert_provider.dart';
import 'package:elhasnaa/provider/locale_provider.dart';
import 'package:elhasnaa/screens/category_details.dart';
import 'package:elhasnaa/screens/register_screen.dart';
import 'package:elhasnaa/screens/registration.dart';
import 'package:elhasnaa/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_context/one_context.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:shared_value/shared_value.dart';

import 'screens/select_country_screen.dart';

main() async {
  // ));
  WidgetsFlutterBinding.ensureInitialized();
  app_language.load();
  country_id.load();
  user_id.load();
  app_mobile_language.load();
  app_language_rtl.load();

  runApp(
    SharedValue.wrapApp(
      MyApp(),
    ),
  );


}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Products? testPro;
  void initState() {
    super.initState();
    //inidata();
  }
  @override
  Widget build(BuildContext context) {
    //========================================
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          ChangeNotifierProvider(create: (_) => AlertProvider()),
        ],
        child: Consumer<LocaleProvider>(builder: (context, provider, snapshot) {
          return OverlaySupport(
            child: MaterialApp(
              builder: OneContext().builder,
              navigatorKey: OneContext().navigator.key,
              title: AppConfig.app_name,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: MyTheme.white,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                accentColor: MyTheme.accent_color,
                // the below code is getting fonts from http
                textTheme: GoogleFonts.sourceSansProTextTheme(textTheme).copyWith(
                  bodyText1:
                  GoogleFonts.sourceSansPro(textStyle: textTheme.bodyText1),
                  bodyText2: GoogleFonts.sourceSansPro(
                      textStyle: textTheme.bodyText2, fontSize: 12),
                ),
              ),
              localizationsDelegates:  const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                AppLocalizations.delegate,
              ],
              locale: provider.locale,
              supportedLocales: LangConfig().supportedLocales(),
              home: Splash(),
              //RegisterScreen(),
              //Splash(),
              // ProductDetails(product:Products.fromJson(proTest),),
              //
              //,const CategoryDetais()
              //Home(),
              //OnBoard(),
              //Splash(),
              // home: Main(),
            ),
          );
        }));
  }
}