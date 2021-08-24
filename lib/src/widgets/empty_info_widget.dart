
import 'package:flutter/material.dart';

class EmptyContainer extends StatelessWidget {

  EmptyContainer({
    @required this.imagen, 
    @required this.mensaje, 
  });

  final String imagen;
  final String mensaje;

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;
    
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric( vertical: 30.0 ),
          child: Image(
            image: AssetImage( 'assets/$imagen' ),
            height: _size.height * 0.2,
            width: _size.width * 0.4,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric( horizontal: 30.0 ),
          child: Text( 'Actualmente no tienes ningún producto agregado a tu $mensaje',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white70
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );

  }

}