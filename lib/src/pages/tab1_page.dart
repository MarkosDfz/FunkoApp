
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:coffishop/src/utils/utils.dart';
import 'package:coffishop/src/models/user_model.dart';
import 'package:coffishop/src/prefs/user_preferences.dart';
import 'package:coffishop/src/services/login_service.dart';
import 'package:coffishop/src/search/search_delegate.dart';
import 'package:coffishop/src/widgets/card_catg_widget.dart';
import 'package:coffishop/src/services/products_service.dart';
import 'package:coffishop/src/widgets/card_weed_swiper_widget.dart';

class Tab1Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final prodService = Provider.of<ProductsService>(context);

    return Container(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _AppBar(),
                  _SearchBar(),
                  _titulos( context, 'Los más buscados', FontAwesomeIcons.hotjar ),
                  ( prodService.productosMasBuscados.length == 0 )
                  ? Center( child: CircularProgressIndicator() )
                  : CardWeedSwiper( productos: prodService.productosMasBuscados ),
                  _titulos( context, 'Categorías', FontAwesomeIcons.rocket ),
                  ( prodService.categorias.length == 0 )
                  ? Center( child: CircularProgressIndicator() )
                  : CardCategories( categorias: prodService.categorias )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


Widget _titulos( BuildContext context, String titulo, IconData icono ) {

  return Padding(
      padding: const EdgeInsets.symmetric( vertical: 15.0, horizontal: 20.0 ),
      child: Row(
        children: <Widget>[
          Icon(
            icono,
            color: Theme.of(context).primaryColor,
            size: 18.0,
          ),
          SizedBox( width: 8.0 ),
          Text( titulo,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Theme.of(context).primaryColor
            )
          ),
        ],
      ),
    );

}

class _SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20.0, vertical: 10.0 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text( 'Explorar' ,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
              color: Theme.of(context).primaryColor
            )
          ),
          Container(
            padding: EdgeInsets.symmetric( vertical: 15.0 ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Busca tu funko pop..',
                hoverColor: Colors.white,
                fillColor: Colors.white,
                suffixIcon: Icon( Icons.search, color: Colors.white70 )
              ),
              onTap: () {
                showSearch(
                  context: context,
                  delegate: DataSearch()
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _prefs       = new PreferenciasUsuario();
    final loginService = Provider.of<LoginService>(context);
    final prodService  = Provider.of<ProductsService>(context);
    UserDB user        = ( _prefs.isRemember == false )
                       ? loginService.usuario
                       : prodService.usuario;

    return Container(
      padding: EdgeInsets.symmetric( vertical: 15.0, horizontal: 20.0 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 22.0,
                backgroundImage: AssetImage( 'assets/avatar.png' ),
              ),
              SizedBox( width: 16.0 ),
              (user != null )
              ? Text( 'Hola, ${ user.username }',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Theme.of(context).primaryColor
                )
              )
              : Container()
              ,
            ],
          ),
          IconButton(
            icon: Icon( FontAwesomeIcons.signOutAlt, size: 20.0 ),
            onPressed: () {
              final prodService = Provider.of<ProductsService>(context, listen: false);
              mostarAlerta( context, 'Confirmar' ,
                '¿Desea cerrar su sesión?',
                FlatButton(
                    child: Text( 'Aceptar' ),
                    onPressed: () {
                      prodService.logOut();
                      Navigator.pushReplacementNamed( context, 'init' );
                    }
                ),
                FlatButton(
                    child: Text( 'Cancelar' ),
                    onPressed: () => Navigator.of(context).pop(),
                )
              );
            }
          )
        ],
      ),
    );
  }
}