
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:coffishop/src/services/products_service.dart';
import 'package:coffishop/src/widgets/empty_info_widget.dart';
import 'package:coffishop/src/widgets/products_list_widget.dart';

class Tab2Page extends StatelessWidget {

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
          title: Text( 'Favoritos',
            style: TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold ) 
          ),
          centerTitle: true,
          leading: Container()
        ),
        backgroundColor: Colors.transparent,
        body: ( prodService.favoritos.length == 0 ) ?
        EmptyContainer(imagen: 'fav.png', mensaje: 'Lista de Favoritos', ) :
        Container(
          padding: EdgeInsets.all( 5.0 ),
          child: ProductsList( productos: prodService.favoritos )
        ),
      ),
    );
  }
}