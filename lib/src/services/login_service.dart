
import 'dart:convert';
import 'package:coffishop/src/prefs/db_app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:coffishop/src/utils/utils.dart';
import 'package:coffishop/src/models/user_model.dart';
import 'package:coffishop/src/prefs/user_preferences.dart';
import 'package:coffishop/src/validation/validation_item.dart';

final _urlApi = '';

class LoginService with ChangeNotifier {

  final _prefs = new PreferenciasUsuario();

  // Data Type
  UserDB _usuario;
  bool _isloading             = false;
  bool _isRemember            = false;
  bool _isVisiblePass         = false;
  ValidationItem _email       = ValidationItem( null, null );
  ValidationItem _pass        = ValidationItem( null, null );
  ValidationItem _confirmPass = ValidationItem( null, null );
  ValidationItem _userName    = ValidationItem( null, null );

  // Getters
  get usuario                    => _usuario;
  get isLoading                  => _isloading;
  get isRemember                 => _isRemember;
  get isVisiblePass              => _isVisiblePass;
  ValidationItem get pass        => _pass;
  ValidationItem get email       => _email;
  ValidationItem get userName    => _userName;
  ValidationItem get confirmPass => _confirmPass;

  bool get isValidForm {
    if ( _email.value != null && _pass.value != null ){
      return true;
    } else {
      return false;
    }
  }

  bool get isValidFormRegister {
    if ( _userName != null && _email.value != null && _pass.value != null && _confirmPass.value != null ){
      return true;
    } else {
      return false;
    }
  }

  // Setters
  set isRemember( bool value ) {
    this._isRemember = value;
    notifyListeners();
  }

  set usuario( UserDB user ) {
    this._usuario = user;
    notifyListeners();
  }

  set isVisiblePass( bool value ) {
    this._isVisiblePass = value;
    notifyListeners();
  }

  set isLoading( bool value ) {
    this._isloading = value;
    notifyListeners();
  }

  // Funtions
  void validateEmail( String value ) {

    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp( pattern );

    if ( regExp.hasMatch( value ) ) {
      _email = ValidationItem( value, null );
    } else {
      _email = ValidationItem( null, 'Ingrese un email válido' );
    }

    notifyListeners();

  }

  void validatePass( String value ) {

    if ( value.length >= 3 ){
      _pass = ValidationItem( value, null ) ;
    } else {
      _pass = ValidationItem( null, 'Contraseña muy corta' );
    }

    notifyListeners();

  }

  void validateconfirmPass( String value ) {

    if ( _pass.value == value ){
      _confirmPass = ValidationItem( value, null) ;
    } else {
      _confirmPass = ValidationItem( null, 'Las contraseñas no coinciden' );
    }

    notifyListeners();

  }

  void validateUsuario( String value ) {

    if ( value.length >= 3 ){
      _userName = ValidationItem( value, null) ;
    } else {
      _userName = ValidationItem( null, 'Usuario muy corto' );
    }

    notifyListeners();

  }

  login( String email, String password ) async {

    final coneccion = await checkNetwork();

    if ( coneccion == false ) {
      return { 'ok' : false, 'mensaje' : 'No tiene conexión a internet, compruebe y vuelva a intentar' };
    }

    final authData = {
      'identifier' : email,
      'password'   : password,
    };

    final resp = await http.post('$_urlApi/auth/local', body: authData );

    Map<String, dynamic> decodeResp = json.decode( resp.body );

    if ( decodeResp.containsKey( 'jwt' ) ) {

      var user = new UserDB(
        email      : decodeResp['user']['email'],
        id         : decodeResp['user']['id'],
        idFavorite : ( decodeResp['user']['idFavorite'] == null ) ? '' : decodeResp['user']['idFavorite']['id'],
        username   : decodeResp['user']['username'],
        token      : decodeResp[ 'jwt' ],
        isRemember :  ( _isRemember == true ) ? 1 : 0
      );

      if ( _isRemember == true) {
        DBProvider.db.nuevoUsuario(user);
      } else {
        this._usuario = user;
      }
      _prefs.token  = decodeResp[ 'jwt' ];
      _prefs.favId  = user.idFavorite;
      _prefs.userId = user.id;
      _prefs.isRemember = _isRemember;
      return { 'ok' : true  };
    } else {
      return { 'ok' : false, 'mensaje' : decodeResp['message'][0]['messages'][0]['message'] };
    }

  }

  register( String username, String email, String password ) async {

    final coneccion = await checkNetwork();

    if ( coneccion == false ) {
      return { 'ok' : false, 'mensaje' : 'No tiene conexión a internet, compruebe y vuelva a intentar' };
    }

    final registerData = {
      'username' : username,
      'email'    : email,
      'password' : password,
    };

    final resp = await http.post('$_urlApi/auth/local/register', body: registerData );

    Map<String, dynamic> decodeResp = json.decode( resp.body );

    if ( decodeResp.containsKey( 'jwt' ) ) {

      _usuario = new UserDB(
        email      : decodeResp['user']['email'],
        id         : decodeResp['user']['id'],
        idFavorite : ( decodeResp['user']['idFavorite'] == null ) ? '' : decodeResp['user']['idFavorite']['id'],
        username   : decodeResp['user']['username'],
        token      : decodeResp[ 'jwt' ],
        isRemember : 0
      );
      
      _prefs.token  = decodeResp[ 'jwt' ];
      _prefs.favId  = _usuario.idFavorite;
      _prefs.userId = _usuario.id;
      return { 'ok' : true  };
    } else {
      return { 'ok' : false, 'mensaje' : decodeResp['message'][0]['messages'][0]['message'] };
    }

  }

}