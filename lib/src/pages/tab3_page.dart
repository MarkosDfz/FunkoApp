
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:coffishop/src/models/categories_model.dart';
import 'package:coffishop/src/widgets/empty_info_widget.dart';
import 'package:coffishop/src/services/products_service.dart';

class Tab3Page extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final prodService = Provider.of<ProductsService>(context);

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
          title: Text( 'Carrito de Compras',
            style: TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold ) 
          ),
          centerTitle: true,
          leading: Container()
        ),
        backgroundColor: Colors.transparent,
        body: ( prodService.carrito.length == 0 ) ?
        EmptyContainer(imagen: 'cart.png', mensaje: 'Carrito de Compras', ) :
        SingleChildScrollView(
          physics:  ScrollPhysics( parent: ClampingScrollPhysics() ),
          child: Column(
            children: <Widget>[
              _listaCarrito( context ),
              Container(
                padding: EdgeInsets.only( top: 15.0 ),
                child: OutlineButton(
                  padding: EdgeInsets.symmetric(  horizontal: 30.0, vertical: 5.0),
                  child: Text( 'Pagar \$ ${ prodService.precioFinal }',
                    style: TextStyle(
                      fontSize: 18.0
                    ),
                  ),
                  shape: StadiumBorder(),
                  borderSide: BorderSide( width: 2, color: Colors.white30 ),
                  highlightedBorderColor: Colors.white30,
                  onPressed: () {
                    _paidModalBottomSheet( context );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _paidModalBottomSheet( BuildContext context ) {

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 270,
          padding: EdgeInsets.symmetric( vertical: 25.0, horizontal: 30.0 ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff262A2D),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular( 40.0 ),
              topLeft: Radius.circular( 40.0 )
            )
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only( bottom: 15.0 ),
                child: Text('Facturación',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric( vertical: 10.0 ),
                child: _crearDropdownPago( context )
              ),
              Divider(
                height: 20.0,
                color: Colors.white70 ,
              ),
              Container(
                padding: EdgeInsets.symmetric( vertical: 10.0 ),
                child: _crearDropdownEnvio( context )
              ),
              Container(
                padding: EdgeInsets.only( top: 14.0 ),
                child: OutlineButton(
                  padding: EdgeInsets.symmetric(  horizontal: 30.0, vertical: 5.0 ),
                  child: Text( '\$ Confirmar Compra',
                    style: TextStyle(
                      fontSize: 14.0
                    ),
                  ),
                  shape: StadiumBorder(),
                  borderSide: BorderSide( width: 2, color: Colors.white30 ),
                  highlightedBorderColor: Colors.white30,
                  onPressed: () {}
                ),
              ),
            ],
          ),
        );
      }
    );

  }

  Widget _crearDropdownPago( BuildContext context ) {

    final prodService = Provider.of<ProductsService>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text( 'Método de Pago',
          style: TextStyle(
            color: Colors.white70 ,
            fontSize: 16.0
          )
        ),
        DropdownButton(
          isDense: true,
          iconSize: 14.0,
          underline: Container(),
          style: TextStyle(
            color: Colors.white70,
          ),
          icon: Icon( Icons.arrow_forward_ios ),
          value: prodService.optSelectPago,
          items: prodService.getOpcionesPagoDropdown(),
          onChanged: (opt) {
            prodService.optSelectPago = opt;
          }
        ),
      ],
    );

  }

  Widget _crearDropdownEnvio( BuildContext context ) {

    final prodService = Provider.of<ProductsService>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text( 'Método de Envío',
          style: TextStyle(
            color: Colors.white70 ,
            fontSize: 16.0
          )
        ),
        DropdownButton(
          isDense: true,
          iconSize: 14.0,
          underline: Container(),
          style: TextStyle(
            color: Colors.white70
          ),
          icon: Icon( Icons.arrow_forward_ios ),
          value: prodService.optSelectEnvio,
          items: prodService.getOpcionesEnvioDropdown(),
          onChanged: (opt) {
            prodService.optSelectEnvio = opt;
          }
        ),
      ],
    );

  }

  Widget _listaCarrito( BuildContext context ) {

    final prodService = Provider.of<ProductsService>(context);
    final List<Product> producto = prodService.carrito;
    final _size = MediaQuery.of(context).size;

    return ListView.builder(
      shrinkWrap: true,
      physics:  ScrollPhysics( parent: ClampingScrollPhysics() ),
      scrollDirection: Axis.vertical,
      itemCount: producto.length,
      itemBuilder: ( BuildContext context, int index ) {
        return Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Card(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular( 20.0 )
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular( 40.0 ),
                    child: Container(
                      height: 94.0,
                      width: _size.width * 0.82,
                      color: Color(0xff262A2D),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 200.0,
                            padding: EdgeInsets.only( left: 33.0 ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text( '${ producto[index].prodName }',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                SizedBox( height: 5.0 ),
                                Text( 'Cantidad: ${ producto[index].prodQuantity }',
                                  style: TextStyle(
                                    fontSize: 13.0
                                  )
                                )
                              ],
                            ),
                          ),
                          Container(
                            // color: Colors.white,
                            padding: EdgeInsets.only( right: 20.0 ),
                            child: Text( '\$ ${ producto[index].prodPrice }',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox( width: 30.0 )
              ],
            ),
            Positioned(
              top: 10.0,
              left: 12.0,
              child: FadeInImage(
                width: 80.0,
                height: 80.0,
                placeholder: AssetImage( 'assets/load1.gif' ),
                image: NetworkImage( producto[index].prodImagePath )
              ),
            ),
            Positioned(
              top: 28.0,
              right: -9.0,
              child: OutlineButton(
                padding: EdgeInsets.symmetric(  horizontal: 10.0, vertical: 2.0),
                child: Icon( Icons.clear, color: Colors.white, size: 16.0 ),
                shape: CircleBorder(),
                borderSide: BorderSide( width: 1, color: Colors.white30 ),
                highlightedBorderColor: Colors.white30,
                onPressed: () {
                  final prodService = Provider.of<ProductsService>(context, listen: false);
                  prodService.restaPrecioFinal( producto[index] );
                },
              ),
            )
          ],
        );
      },
    );

  }

}

