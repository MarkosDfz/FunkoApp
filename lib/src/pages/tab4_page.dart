
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:coffishop/src/utils/utils.dart';
import 'package:coffishop/src/models/user_model.dart';
import 'package:coffishop/src/prefs/user_preferences.dart';
import 'package:coffishop/src/services/login_service.dart';
import 'package:coffishop/src/services/products_service.dart';

class Tab4Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _prefs       = new PreferenciasUsuario();
    final loginService = Provider.of<LoginService>(context);
    final prodService  = Provider.of<ProductsService>(context);
    UserDB user        = ( _prefs.isRemember == false )
                       ? loginService.usuario
                       : prodService.usuario;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage( 'assets/back.jpg' ),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text( 'Tu Perfil',
            style: TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold ) 
          ),
          centerTitle: true,
          leading: Container()
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.symmetric( vertical:  18.0, horizontal: 30.0 ),
          child: Column(
            children: <Widget>[
              _mostarAvatar( context ),
              SizedBox( height: 20.0 ),
              _mostrarUser( context, user ),
              SizedBox( height: 14.0 ),
              _mostrarEmail( context, user ),
              SizedBox( height: 30.0 ),
              _mostrarBoton( context ),
            ],
          ),
        )
      ),
    );
  }

  Widget _mostarAvatar( BuildContext context ) {

    return Container(
      padding: EdgeInsets.all(10.0),
      child: CircleAvatar(
        radius: 82.0,
        backgroundImage: AssetImage( 'assets/avatar.png' ),
      ),
    );

  }

  Widget _mostrarUser( BuildContext context, UserDB user ) {

    return TextField(
      enabled: false,
      autofocus: false,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.white70,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular( 20.0 ),
        ),
        labelText: '${ user.username }',
        suffixIcon: Icon( Icons.sentiment_satisfied, color: Colors.white54 ),
      ),
    );

  }

  Widget _mostrarEmail( BuildContext context, UserDB user ) {

    return TextField(
      enabled: false,
      autofocus: false,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.white70,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular( 20.0 ),
        ),
        labelText: '${ user.email }',
        suffixIcon: Icon( Icons.alternate_email, color: Colors.white54 ),
      ),
    );

  }

  Widget _mostrarBoton( BuildContext context ) {

    return OutlineButton(
      padding: EdgeInsets.symmetric(  horizontal: 30.0, vertical: 5.0 ),
      child: Text( 'Cerrar Sesión',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Colors.white70
        ),
      ),
      shape: StadiumBorder(),
      borderSide: BorderSide( width: 2, color: Colors.white30 ),
      highlightedBorderColor: Colors.white30,
      onPressed:  () {
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
    );

  }
}