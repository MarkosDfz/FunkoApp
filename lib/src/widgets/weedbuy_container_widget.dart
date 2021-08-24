
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:coffishop/src/models/categories_model.dart';
import 'package:coffishop/src/services/products_service.dart';

class WeedBuyContainer extends StatelessWidget {

  final Product product;
  final GlobalKey<ScaffoldState> scaffoldKey;
  
  WeedBuyContainer( { @required this.product, @required this.scaffoldKey } );
  
  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size; 

    return Container(
      decoration: BoxDecoration(
        color: Color(0xff262A2D),
        borderRadius: BorderRadius.circular( 44.0 )
      ),
      height: 680.0 ,
      width: _size.width * 0.9,
      child: Column(
        children: <Widget>[
          _headContainerWidget( context, product ),
          ( product.prodType == 'Producto') ? Container() : _cuadrosContainerWidget( context, product ),
          _decripcionContainerWidget( product ),
          _precioContainerWidget( context, product ),
          _footerContainerWidget( context, product, scaffoldKey )
        ],
      ),
    );
  }
}

Widget _precioContainerWidget( BuildContext context, Product product ) {

  final prodService = Provider.of<ProductsService>(context);

  return Container(
    child: Column(
      children: <Widget>[
        Container(
          height: 50.0,
          width: 200,
          margin: EdgeInsets.symmetric( vertical: 10.0, horizontal: 15.0 ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white30,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular( 20.0 )
          ),
          child: Center(
            child: Text( '\$${ prodService.precio }',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              )
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric( vertical: 16.0 ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OutlineButton(
                padding: EdgeInsets.symmetric(  horizontal: 30.0, vertical: 8.0),
                child: Icon( Icons.arrow_left, color: Colors.white ),
                shape: CircleBorder(),
                borderSide: BorderSide( width: 1, color: Colors.white30 ),
                highlightedBorderColor: Colors.white30,
                onPressed: () {
                final prodService = Provider.of<ProductsService>(context, listen: false);
                 if ( prodService.cantidad > 1 ) {
                    prodService.cantidad--;
                    prodService.restarPrecio();
                  }
                },
              ),
              Text( '${ prodService.cantidad }',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold
                )
              ),
              OutlineButton(
                padding: EdgeInsets.symmetric(  horizontal: 30.0, vertical: 8.0),
                child: Icon( Icons.arrow_right, color: Colors.white ),
                shape: CircleBorder(),
                borderSide: BorderSide( width: 1, color: Colors.white30 ),
                highlightedBorderColor: Colors.white30,
                onPressed: () {
                  final prodService = Provider.of<ProductsService>(context, listen: false);
                  prodService.cantidad++;
                  prodService.sumaPrecio();
                },
              ),
            ],
          ),
        )
      ],
    ),
  );

}

Widget _footerContainerWidget( BuildContext context, Product product, GlobalKey<ScaffoldState> scaffoldKey ) {

  final prodService = Provider.of<ProductsService>( context);

  return Container(
    padding: EdgeInsets.only( top: 10.0 ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        OutlineButton(
          padding: EdgeInsets.symmetric(  horizontal: 30.0, vertical: 8.0 ),
          child: Icon(
            ( prodService.esFavorito == false ) ? FontAwesomeIcons.heart : FontAwesomeIcons.solidHeart,
            color: Colors.red
          ),
          shape: StadiumBorder(),
          borderSide: BorderSide( width: 2, color: Colors.white30 ),
          highlightedBorderColor: Colors.white30,
          onPressed: () {
            final prodService = Provider.of<ProductsService>( context, listen: false );
            prodService.favoritos = product;
          },
        ),
        SizedBox( width: 12.0 ),
        OutlineButton(
          padding: EdgeInsets.symmetric(  horizontal: 30.0, vertical: 10.0),
          child: Text('Agregar al Carrito'),
          shape: StadiumBorder(),
          borderSide: BorderSide( width: 2, color: Colors.white30 ),
          highlightedBorderColor: Colors.white30,
          onPressed: () {
            final prodService = Provider.of<ProductsService>( context, listen: false );
            prodService.carrito = product;
            prodService.mostrarSnackBar( scaffoldKey, 'Se agrego ${ product.prodName } al carrito' );
          },
        )
      ],
    ),
  );

}

Widget _decripcionContainerWidget( Product product ) {

  return Container(
    padding: EdgeInsets.symmetric( horizontal: 25.0, vertical: 10.0 ),
    child: Text( product.prodDescription,
      maxLines: 7,
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 15.0
      ),
    ),
  );

}

Widget _cuadrosContainerWidget( BuildContext context, Product product ){

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0 ),
    child: Table(
      children: [
        TableRow(
          children: [
            Container(
              height: 140.0,
              margin: EdgeInsets.symmetric( vertical: 15.0, horizontal: 15.0 ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white30,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular( 20.0 )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric( vertical: 10.0 ),
                    child: Text( 'Alto',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 18.0,
                      )
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text( product.thc,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      SizedBox( width: 2.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon( FontAwesomeIcons.handPointUp, size: 20.0 ),
                          Text( 'CM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 140.0,
              margin: EdgeInsets.symmetric( vertical: 15.0, horizontal: 15.0 ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white30,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular( 20.0 )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric( vertical: 10.0 ),
                    child: Text( 'Ancho',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 18.0,
                      )
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text( product.cbd,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      SizedBox( width: 2.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon( FontAwesomeIcons.handPointRight, size: 20.0 ),
                          Text( 'CM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ]
        ),
      ],
    ),
  );

}

Widget _headContainerWidget( BuildContext context, Product product ) {

  return Container(
    padding: EdgeInsets.symmetric( vertical: 25.0, horizontal: 25.0 ),
    child: Row(
      children: <Widget>[
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              OutlineButton(
                padding: EdgeInsets.symmetric(  horizontal: 30.0, vertical: 8.0),
                child: Icon( Icons.keyboard_backspace, color: Colors.white, size: 30.0, ),
                shape: StadiumBorder(),
                borderSide: BorderSide( width: 2, color: Colors.white30 ),
                highlightedBorderColor: Colors.white30,
                onPressed: () {
                    Navigator.pop(context);
                },
              ),
              SizedBox( height: 20.0 ),
              Text( product.prodType,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 18.0,
                )
              ),
              Text( product.prodName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                )
              )
            ],
          )
        )
      ],
    ),
  );

}