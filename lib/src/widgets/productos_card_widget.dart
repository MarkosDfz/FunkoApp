
import 'package:flutter/material.dart';

import 'package:coffishop/src/models/categories_model.dart';

class ProductosCard extends StatelessWidget {

  final List<Product> productos;
  final int index;
  final bool mostrarPrecio;

  ProductosCard( { @required this.productos, this.index, this.mostrarPrecio } );


  @override
  Widget build( BuildContext context ) {

    final _size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular( 20.0 )
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular( 20.0 ),
        child: Container(
          width: _size.width * 0.55,
          height: 280.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage( 'assets/fondocard.jpg' ),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: EdgeInsets.all( 25.0 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: ( mostrarPrecio ) ? '${productos[index].id}prodPrecio' : productos[index].id,
                  child: FadeInImage(
                    width: 160.0,
                    height: 160.0,
                    placeholder: AssetImage( 'assets/load.gif' ),
                    image: NetworkImage( productos[index].prodImagePath )
                  )
                ),
                SizedBox( height: 10.0 ),
                Text( productos[index].prodName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ( mostrarPrecio == true ) ? 15 : 20.0, 
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox( height: 5.0 ),
                Text( ( !mostrarPrecio ) ? productos[index].prodType : ' \$ ${ productos[index].prodPrice } ' ,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: ( mostrarPrecio == true ) ? 16 : 18.0,
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}