
import 'package:coffishop/src/prefs/db_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';
import 'package:coffishop/src/routes/routes.dart';
import 'package:coffishop/src/pages/init_page.dart';
import 'package:coffishop/src/pages/tabs_page.dart';
import 'package:coffishop/src/prefs/user_preferences.dart';
import 'package:coffishop/src/services/login_service.dart';
import 'package:coffishop/src/services/products_service.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {

  final _prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    if (_prefs.userId == '' && _prefs.token == '' ) {
      DBProvider.db.deleteAll() ;
    }

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ) );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (_) => new LoginService() ),
        ChangeNotifierProvider( create: (_) => new ProductsService() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: ( _prefs.isRemember == true && _prefs.token != '' ) ? TabsPage() : InitPage() ,
        theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xff262A2D),
        primaryColor: Colors.white,
        accentColor: Color(0xff262A2D)
        ),
        routes: getAplicationRoutes()
      ),
    );
  }
}