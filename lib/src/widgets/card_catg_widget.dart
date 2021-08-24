
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:coffishop/src/models/categories_model.dart';
import 'package:coffishop/src/services/products_service.dart';

class CardCategories extends StatelessWidget {

  final List<Categories> categorias;

  CardCategories( { @required this.categorias } );

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: 230,
      child: Swiper(
        itemWidth: _size.width * 0.6,
        itemHeight: _size.height * 0.5,
        itemCount: categorias.length,
        viewportFraction: 0.8,
        scale: 0.8,
        itemBuilder: ( BuildContext context, int i) {
          return _tarjetaCat( context, i );
        },
      )
    );

  }

  Widget _tarjetaCat( BuildContext context, int i ) {

    final _size = MediaQuery.of(context).size;

    final categoriaTarjeta = Container(
      width: double.infinity,
      height: 200.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular( 20.0 )
        ),
        child:ClipRRect(
          borderRadius: BorderRadius.circular( 20.0 ),
          child: Container(
            width: _size.width * 0.55,
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage( 'assets/back.jpg' ),
                fit: BoxFit.cover
              )
            ),
            child: Center(
              child: Text( categorias[i].description,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ),
        ),
      ),
    );

    return GestureDetector(
      child: categoriaTarjeta,
      onTap: () {
        final prodService = Provider.of<ProductsService>(context, listen: false);
        Navigator.pushNamed( context, 'categoria', arguments: categorias[i].description );
        prodService.productosCategorias = categorias[i].products;
      },
    );
  }
}