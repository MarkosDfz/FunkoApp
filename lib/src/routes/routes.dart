
import 'package:flutter/material.dart';

import 'package:coffishop/src/pages/init_page.dart';
import 'package:coffishop/src/pages/tabs_page.dart';
import 'package:coffishop/src/pages/login_page.dart';
import 'package:coffishop/src/pages/register_page.dart';
import 'package:coffishop/src/pages/categories_page.dart';
import 'package:coffishop/src/pages/weed_product_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {

  return <String, WidgetBuilder>{
    'init'        : ( BuildContext context ) => InitPage(),
    'home'        : ( BuildContext context ) => TabsPage(),
    'login'       : ( BuildContext context ) => LoginPage(),
    'register'    : ( BuildContext context ) => RegisterPage(),
    'categoria'   : ( BuildContext context ) => CategoriesPage(),
    'detalleWeed' : ( BuildContext context ) => WeedProductPage(),
  };

}