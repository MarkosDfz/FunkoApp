
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:coffishop/src/models/categories_model.dart';
import 'package:coffishop/src/services/products_service.dart';
import 'package:coffishop/src/widgets/weedbuy_container_widget.dart';

class WeedProductPage extends StatelessWidget {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final prodService = Provider.of<ProductsService>(context);
    final Product producto = prodService.producto;
    
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage( 'assets/back.jpg' ),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric( vertical: 5.0, horizontal: 20.0 ),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only( top: 30.0 ),
                    child: WeedBuyContainer( product: producto, scaffoldKey: scaffoldKey )
                  ),
                  Positioned(
                    top: -4.0,
                    right: -8.0,
                    child: Hero(
                      tag: producto.id,
                      child: FadeInImage(
                        height: 200.0,
                        width: 200.0,
                        placeholder: AssetImage( 'assets/load.gif' ),
                        image: NetworkImage( prodService.producto.prodImagePath )
                      )
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }

}

