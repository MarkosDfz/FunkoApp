
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:coffishop/src/utils/utils.dart';
import 'package:coffishop/src/services/login_service.dart';
import 'package:coffishop/src/services/products_service.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginService = Provider.of<LoginService>(context);
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                height: _size.height * 0.06,
              ),
              Container(
                color: Colors.black,
                width: double.infinity,
                height: _size.height * 0.4,
                child: Image(
                  image: AssetImage( 'assets/logo.png' ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric( vertical:  26.0, horizontal: 30.0 ),
                child: Column(
                  children: <Widget>[
                    _crearEmail( context ),
                    SizedBox( height: 14.0 ),
                    _crearPassword( context ),
                    SizedBox( height: 14.0 ),
                    _crearRemember( context ),
                    ( loginService.isLoading == true )
                    ? CircularProgressIndicator( backgroundColor: Colors.red )
                    : _crearBoton( context ),
                    SizedBox( height: 25.0 ),
                    GestureDetector(
                      child: Text('¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      onTap: () {},
                    ),
                    SizedBox( height: 12.0 ),
                    GestureDetector(
                      child: Text('¿No tienes una cuenta? Registrate',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed( context, 'register' );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearRemember( BuildContext context ) {

    final loginService = Provider.of<LoginService>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text( '¿Recordar Cuenta?',
          style: TextStyle( color: Colors.white70, fontSize: 13.5, ),
        ),
        Switch(
          activeColor: Colors.red,
          value: loginService.isRemember,
          onChanged: ( value ) {
            loginService.isRemember = value;
          }
        ),
      ],
    );

  }

  Widget _crearEmail( BuildContext context ) {

    final loginService = Provider.of<LoginService>(context);

    return TextField(
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        errorText: loginService.email.error,
        labelStyle: TextStyle(
          color: Colors.white70,
        ),
        focusedBorder:OutlineInputBorder(
          borderSide: BorderSide( color: Colors.white54, width: 2.0 ),
          borderRadius: BorderRadius.circular( 20.0 ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular( 20.0 ),
        ),
        labelText: 'Correo electrónico',
        suffixIcon: Icon( Icons.alternate_email, color: Colors.white54 ),
      ),
      onChanged: ( String value ) {
        loginService.validateEmail( value );
      },
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
    );

  }

  Widget _crearPassword( BuildContext context ) {

    final loginService = Provider.of<LoginService>(context);

    return TextField(
      autofocus: false,
      obscureText: !loginService.isVisiblePass,
      decoration: InputDecoration(
        errorText: loginService.pass.error,
        labelStyle: TextStyle(
          color: Colors.white70,
        ),
        focusedBorder:OutlineInputBorder(
          borderSide: BorderSide( color: Colors.white54, width: 2.0 ),
          borderRadius: BorderRadius.circular( 20.0 ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular( 20.0 ),
        ),
        labelText: 'Contraseña',
        suffixIcon: IconButton(
          icon: !loginService.isVisiblePass
                ? Icon( Icons.remove_red_eye, color: Colors.white54 )
                : Icon( Icons.visibility_off, color: Colors.white54 ),
          onPressed: () {
            final loginService = Provider.of<LoginService>( context, listen: false );
            loginService.isVisiblePass = !loginService.isVisiblePass;
          }
        )
      ),
      onChanged: ( String value ) {
        loginService.validatePass( value );
      },
    );

  }

  Widget _crearBoton( BuildContext context ) {

    final loginService = Provider.of<LoginService>( context, listen: false );

    return OutlineButton(
      padding: EdgeInsets.symmetric(  horizontal: 30.0, vertical: 5.0 ),
      child: Text( 'Ingresar',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Colors.white70
        ),
      ),
      shape: StadiumBorder(),
      borderSide: BorderSide( width: 2, color: Colors.white30 ),
      highlightedBorderColor: Colors.white30,
      onPressed: loginService.isValidForm ? () => _login( context ) : null
    );

  }

  _login( BuildContext context ) async {
    
    final loginService = Provider.of<LoginService>(context, listen: false);
    
    loginService.isLoading = true;

    Map info = await loginService.login( loginService.email.value, loginService.pass.value );

    if ( info[ 'ok' ] ) {
      loginService.isLoading = false;
      Navigator.pushReplacementNamed( context, 'home' );
      final prodService  = Provider.of<ProductsService>(context, listen: false);
      prodService.getFavorites();
    } else {
      loginService.isLoading = false;
      mostarAlerta( context, 'Error' ,
        info[ 'mensaje' ],
        FlatButton(
            child: Text( 'Aceptar' ),
            onPressed: () => Navigator.of(context).pop(),
        )
      );
    }

  }

}