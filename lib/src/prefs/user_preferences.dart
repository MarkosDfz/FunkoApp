
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // Getters
  get token       => _prefs.getString( 'token' ) ?? '';
  get favId       => _prefs.getString( 'favId' ) ?? '';
  get userId      => _prefs.getString( 'userId' ) ?? '';
  get isRemember  => _prefs.getBool( 'isRemember' ) ?? false;

  // Setters
  set token( String value ) {
    _prefs.setString( 'token', value );
  }

  set favId( String value ) {
    _prefs.setString( 'favId', value );
  }

  set userId( String value ) {
    _prefs.setString( 'userId', value );
  }

  set isRemember( bool value ) {
    _prefs.setBool( 'isRemember', value );
  }
}