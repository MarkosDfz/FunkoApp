
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:coffishop/src/utils/utils.dart';
import 'package:coffishop/src/services/login_service.dart';

class RegisterPage extends StatelessWidget {
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
                width: double.infinity,
                height: _size.height * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage( 'assets/logo.png' ),
                  ) 
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric( vertical:  14.0, horizontal: 30.0 ),
                child: Column(
                  children: <Widget>[
                    _crearNombre( context ),
                    SizedBox( height: 14.0 ),
                    _crearEmail( context ),
                    SizedBox( height: 14.0 ),
                    _crearPassword( context ),
                    SizedBox( height: 14.0 ),
                    _crearConfirmPassword( context ),
                    SizedBox( height: 18.0 ),
                    ( loginService.isLoading == true )
                    ? CircularProgressIndicator( backgroundColor: Colors.red )
                    : _crearBoton( context ),
                    SizedBox( height: 16.0 ),
                    GestureDetector(
                      child: Text('¿Ya tienes una cuenta? Inicia Sesión',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed( context, 'login' );
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

  Widget _crearNombre( BuildContext context ) {

    final loginService = Provider.of<LoginService>(context);

    return TextField(
      autofocus: false,
      decoration: InputDecoration(
        errorText: loginService.userName.error,
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
        labelText: 'Usuario',
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      ),
      onChanged: ( String value ) {
        loginService.validateUsuario( value );
      },
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
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
        labelText: 'Correo Electrónico',
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
      obscureText: true,
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
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      ),
      onChanged: ( String value ) {
        loginService.validatePass( value );
      },
    );

  }

  Widget _crearConfirmPassword( BuildContext context ) {

    final loginService = Provider.of<LoginService>(context);

    return TextField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        errorText: loginService.confirmPass.error,
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
        labelText: 'Confirmar Contraseña',
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      ),
      onChanged: ( String value ) {
        loginService.validateconfirmPass( value );
      },
    );

  }

  Widget _crearBoton( BuildContext context ) {

    final loginService = Provider.of<LoginService>( context, listen: false );

    return OutlineButton(
      padding: EdgeInsets.symmetric(  horizontal: 30.0, vertical: 5.0 ),
      child: Text( 'Registrarse',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Colors.white70
        ),
      ),
      shape: StadiumBorder(),
      borderSide: BorderSide( width: 2, color: Colors.white30 ),
      highlightedBorderColor: Colors.white30,
      onPressed: loginService.isValidFormRegister ? () => _register( context ) : null
    );

  }

  _register( BuildContext context ) async {
    
    final loginService = Provider.of<LoginService>(context, listen: false);

    loginService.isLoading = true;

    Map info = await loginService.register( loginService.userName.value ,loginService.email.value, loginService.pass.value );

    if ( info[ 'ok' ] ) {
      loginService.isLoading = false;
      Navigator.pushReplacementNamed( context, 'home' );
    } else {
      loginService.isLoading = false;
      mostarAlerta( context, 'Error',
        info[ 'mensaje' ],
        FlatButton(
            child: Text( 'Aceptar' ),
            onPressed: () => Navigator.of(context).pop(),
        ),
      );
    }

  }
  
}