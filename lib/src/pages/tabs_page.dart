
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:coffishop/src/pages/tab1_page.dart';
import 'package:coffishop/src/pages/tab2_page.dart';
import 'package:coffishop/src/pages/tab3_page.dart';
import 'package:coffishop/src/pages/tab4_page.dart';
import 'package:coffishop/src/services/products_service.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion()
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);
    final prodService = Provider.of<ProductsService>( context);

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.black,
      ),
      child: BottomNavigationBar(
        currentIndex: navegacionModel.paginaActual,
        unselectedItemColor: Colors.grey,
        fixedColor: Color.fromRGBO( 82, 156, 149, 1.0 ),
        onTap: ( int i ) => navegacionModel.paginaActual = i,
        items: [
          BottomNavigationBarItem(
            icon: Icon( Icons.home ),
            title: Text( 'Inicio' ),
          ),
          BottomNavigationBarItem(
            icon: Icon( FontAwesomeIcons.solidHeart ),
            title: Text( 'Favoritos' ),
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget>[
                Icon( FontAwesomeIcons.shoppingBag ),
                Positioned(
                  top:  0.0,
                  right: 0.0,
                  child: ( prodService.qtyCarrito == 0 )
                    ? Container()
                    : Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle
                    ),
                    alignment: Alignment.center,
                    child: Text( '${ prodService.qtyCarrito }',
                      style: TextStyle( color: Colors.white, fontSize: 10.0 )
                    ),
                  ),
                )
              ],
            ),
            title: Text( 'Carrito' ),
          ),
          BottomNavigationBarItem(
            icon: Icon( FontAwesomeIcons.solidUserCircle ),
            title: Text( 'Perfil' ),
          )
        ],
      ),
    );
  }
}

class _Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        Tab2Page(),
        Tab3Page(),
        Tab4Page()
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {

  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual( int valor ) {
    this._paginaActual = valor;
    _pageController.animateToPage( valor, duration: Duration( milliseconds: 250 ), curve: Curves.easeOut );
    notifyListeners();
  }

  PageController get pageController => this._pageController;

}