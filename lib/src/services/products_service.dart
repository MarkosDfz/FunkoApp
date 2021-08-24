
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:coffishop/src/prefs/db_app.dart';
import 'package:coffishop/src/models/fav_model.dart';
import 'package:coffishop/src/models/user_model.dart';
import 'package:coffishop/src/prefs/user_preferences.dart';
import 'package:coffishop/src/models/favorites_model.dart';
import 'package:coffishop/src/models/categories_model.dart';

final _urlApi = '';

class ProductsService with ChangeNotifier {

  final _prefs = new PreferenciasUsuario();

  // Data Type
  UserDB _usuario;
  int _cantidad;
  String _favID;
  double _precio;
  Product _producto;
  int _qtyCarrito                    = 0;
  double _precioFinal                = 0;
  bool _esFavorito                   = false;
  bool _prodEx                       = false;
  List<Product> _carrito             = [];
  List<Product> _favoritos           = [];
  List<Categories> categorias        = [];
  List<Product> _todosProductos      = [];
  List<Product> productosMasBuscados = [];
  List<Product> _productosCategorias = [];
  String _optSelectPago              = 'Apple Pay ';
  String _optSelectEnvio             = 'Por definir ';
  List<String> _metodosEnvio         = [ 'Por definir ', 'Personal ' ];
  List<String> _metodosPago          = [ 'Apple Pay ', 'Paypal ', 'Tarjeta ' ];

  ProductsService() {
    this.getCategories();
    this.getFavorites();
  }

  // Getters
  get favID               => _favID;
  get precio              => _precio;
  get carrito             => _carrito;
  get cantidad            => _cantidad;
  get producto            => _producto;
  get favoritos           => _favoritos;
  get prodEx              => _prodEx;
  get qtyCarrito          => _qtyCarrito;
  get esFavorito          => _esFavorito;
  get precioFinal         => _precioFinal;
  get optSelectPago       => _optSelectPago;
  get optSelectEnvio      => _optSelectEnvio;
  get productosCategorias => _productosCategorias;

  get usuario {
    
    if ( _prefs.isRemember == true ) {
      getUsuario();
    }
    
    return _usuario;
  }

  getUsuario()  {
    DBProvider.db.getUser().then((value) {
      this._usuario = value;
    });
    
  }

  // Setters
  set precioFinal( double valor ) {
    this._precioFinal = valor;
    notifyListeners();
  }

  set esFavorito( bool valor ) {
    this._esFavorito = valor;
    notifyListeners();
  }

  set prodEx( bool valor ) {
    this._prodEx = valor;
    notifyListeners();
  }

  set cantidad( int valor ) {
    this._cantidad = valor;
    notifyListeners();
  }

  set qtyCarrito( int valor ) {
    this._qtyCarrito = valor;
    notifyListeners();
  }

  set precio( double valor ) {
    this._precio = valor;
    notifyListeners();
  }

  set favID( String valor ) {
    this._favID = valor;
    notifyListeners();
  }

  set productosCategorias( valor ) {
    this._productosCategorias = valor;
    notifyListeners();
  }

  set optSelectPago( String valor ) {
    this._optSelectPago = valor;
    notifyListeners();
  }

  set optSelectEnvio( String valor ) {
    this._optSelectEnvio = valor;
    notifyListeners();
  }

  set carrito( Product valor ) {

    var prod = this._carrito.firstWhere((p) => p.productId == valor.productId, orElse: () => null );

    if ( prod != null ) {
      this._prodEx = true;
    } else {
      this._prodEx = false;
    }

    var prodCarrito = new Product(
      productId     : valor.id,
      prodPrice     : ( this._prodEx == true )
                    ? this.precio + prod.prodPrice
                    : this._precio,
      prodName      : valor.prodName,
      prodType      : valor.prodType,
      prodQuantity  : ( this._prodEx == true ) 
                    ? this._cantidad + prod.prodQuantity
                    : this._cantidad,
      prodImagePath : valor.prodImagePath,
    );

    if ( this._prodEx == true ) {
      this._precioFinal = _precioFinal - prod.prodPrice;
      this._carrito.removeWhere((p) => p.productId == valor.productId);
      this._carrito.add( prodCarrito );
    } else{
      this._carrito.add( prodCarrito );
    }

    var sumaFinal    = _precioFinal + prodCarrito.prodPrice;
    this.precioFinal = double.parse( sumaFinal.toStringAsFixed(2) );
    this._qtyCarrito = this._carrito.length;

    notifyListeners();
  
  }

  set favoritos(  Product valor ) {

    if ( _prefs.favId == '' ) {
      postFavorito( valor );
      
    } else {
      if ( this._favoritos.contains( valor ) ) {
        this._favoritos.remove( valor );
        updateFavorito( valor, false );
        this._esFavorito = false;
      } else {
        updateFavorito( valor, true );
        this._esFavorito = true;
      }
    }
    
    notifyListeners();
  }

  set producto( String name ) {

    this._producto = _todosProductos.singleWhere((p) => p.prodName == name );
    this._precio = this._producto.prodPrice;
    this._cantidad = 1;
    this._esFavorito = false;

    if ( this._favoritos.contains(this._producto) ) {
      this._esFavorito = true;
    }

    notifyListeners();

  }

  // Funtions
  void logOut() {
    this._prefs.token  = '';
    this._prefs.favId  = '';
    this._prefs.userId = '';
    this._qtyCarrito   = 0;
    this._favoritos    = [];
    this._carrito      = [];
    DBProvider.db.deleteAll();
  }

  void getCategories() async {

    final url = '$_urlApi/categories';

    final header = {
      'Authorization': 'Bearer ${ _prefs.token }'
    };

    final resp = await http.get( url, headers: header );

    final categoriesResponse = categoriesFromJson( resp.body );

    this.categorias.addAll( categoriesResponse );

    productosMasBuscados = categorias[1].products.where((p) => p.prodType != 'Producto' ).toList();

    for ( var item in categorias ) {

      _todosProductos.addAll(item.products);

    }

    notifyListeners();

  }

  void getFavorites() async {

    if( _prefs.favId == '' ) return;

    final url = '$_urlApi/favorites/${ _prefs.favId }';

    final header = {
      'Authorization': 'Bearer ${ _prefs.token }'
    };

    final resp = await http.get( url, headers: header );

    final favoritesResponse = favoritesFromJson( resp.body );

    this.favoritos.addAll( favoritesResponse.idProducts );

    notifyListeners();

  }

  Future<List<Product>> buscarProducts( String query ) async {

    final url = '$_urlApi/products?prodName_contains=$query';

    final header = {
      'Authorization': 'Bearer ${ _prefs.token }'
    };

    final resp = await http.get( url, headers: header );

    final decodeData = json.decode(resp.body);

    final peliculas = new Products.fromJsonList(decodeData);

    return peliculas.items;

  }

  void sumaPrecioFinal(){
    var suma = this._precio + this._producto.prodPrice;
    this._precio = double.parse( suma.toStringAsFixed(2));
    notifyListeners();
  }

  void restarPrecioFinal(){
    var resta = this._precio - this._producto.prodPrice;
    this._precio = double.parse( resta.toStringAsFixed(2));
    notifyListeners();
  }

  void sumaPrecio(){
    var suma = this._precio + this._producto.prodPrice;
    this._precio = double.parse( suma.toStringAsFixed(2));
    notifyListeners();
  }

  void restarPrecio(){
    var resta = this._precio - this._producto.prodPrice;
    this._precio = double.parse( resta.toStringAsFixed(2));
    notifyListeners();
  }

  void restaPrecioFinal( Product prodCarrito ) {
    var restaFinal   = _precioFinal - prodCarrito.prodPrice;
    this.precioFinal = double.parse( restaFinal.toStringAsFixed(2));
    this._carrito.remove( prodCarrito );
    this._qtyCarrito = this._carrito.length;
    notifyListeners();
  }

  void postFavorito( Product valor ) async {

    final header = {
      'Authorization': 'Bearer ${ _prefs.token }'
    };

    final favData = {
      'idProducts' : [{'_id' : '${valor.id}'}],
      'idUser'     : _prefs.userId
    };

    final resp = await http.post('$_urlApi/favorites', headers: header, body: json.encode(favData) );

    final fav = favoritesFromJson(resp.body);

    if( resp.statusCode == 200 ){

      this._favoritos.add( valor );
      this._esFavorito = true;
      this._favID =  fav.id;
      _prefs.favId = fav.id;

    }

    notifyListeners();

  }

  void updateFavorito( Product valor, bool agregar ) async {

    _favID = ( _prefs.favId == '' ) ? null :  _prefs.favId;

    final header = {
      'Authorization': 'Bearer ${ _prefs.token }'
    };

    if ( agregar == true ) {
      this._favoritos.add( valor );
    }

    var favData = new Fav(
      idProducts: this._favoritos,
      idUser: _prefs.userId
    );

    final resp = await http.put('$_urlApi/favorites/$_favID', headers: header, body: favToJson(favData) );

    notifyListeners();

  }

  void mostrarSnackBar( GlobalKey<ScaffoldState> scaffoldKey,  String mensaje ) {

    final snackbar = SnackBar(
      content: Text( mensaje,
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.white
        )
      ),
      backgroundColor: Colors.black,
      duration: Duration( milliseconds: 2500 ),
    );
    
    scaffoldKey.currentState.showSnackBar( snackbar );

    notifyListeners();

  }

  List<DropdownMenuItem<String>> getOpcionesPagoDropdown() {

    List<DropdownMenuItem<String>> lista = new List();

    _metodosPago.forEach( ( metodoPago ) {
      lista.add(
        DropdownMenuItem(
          child: Text( metodoPago ),
          value: metodoPago,
          onTap: () {},
        )
      );
    });

    return lista;
  }

  List<DropdownMenuItem<String>> getOpcionesEnvioDropdown() {

    List<DropdownMenuItem<String>> lista = new List();

    _metodosEnvio.forEach( ( metodoEnvio ) {
      lista.add(
        DropdownMenuItem(
          child: Text( metodoEnvio ),
          value: metodoEnvio,
          onTap: () {},
        )
      );
    });

    return lista;
  }

}