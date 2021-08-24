
import 'package:flutter/material.dart';

class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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
                child: Column(
                  children: <Widget>[
                    SizedBox( height: 40.0 ),
                    _botonLogin( context ),
                    SizedBox( height: 14.0 ),
                    _botonRegister( context ),
                    SizedBox( height: 10.0 ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _botonLogin( BuildContext context ) {

    final _size = MediaQuery.of(context).size;

    return Container(
      height: 42.0,
      width: _size.width * 0.8,
      child: OutlineButton(
        child: Text( 'Iniciar Sesión',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
            color: Colors.white70
          ),
        ),
        shape: StadiumBorder(),
        borderSide: BorderSide( width: 2, color: Colors.white30 ),
        highlightedBorderColor: Colors.white30,
        onPressed: () {
          Navigator.pushReplacementNamed( context, 'login' );
        }
      ),
    );

  }

  Widget _botonRegister( BuildContext context ) {

    final _size = MediaQuery.of(context).size;

    return Container(
      height: 42.0,
      width: _size.width * 0.8,
      child: OutlineButton(
        child: Text( 'Crear una cuenta',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
            color: Colors.white70
          ),
        ),
        shape: StadiumBorder(),
        borderSide: BorderSide( width: 2, color: Colors.white30 ),
        highlightedBorderColor: Colors.white30,
        onPressed: () {
          Navigator.pushReplacementNamed( context, 'register' );
        }
      ),
    );

  }


}