
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:coffishop/src/models/categories_model.dart';
import 'package:coffishop/src/services/products_service.dart';
import 'package:coffishop/src/widgets/productos_card_widget.dart';

class CardWeedSwiper extends StatelessWidget {

  final List<Product> productos;

  CardWeedSwiper( { @required this.productos } );

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: 300,
      child: Swiper(
        itemWidth: _size.width * 0.6,
        itemHeight: _size.height * 0.5,
        itemCount: productos.length,
        viewportFraction: 0.8,
        scale: 0.8,
        itemBuilder: ( BuildContext context, int i ) {
          return GestureDetector(
            child: ProductosCard(
              productos: productos,
              index: i,
              mostrarPrecio: false,
            ),
            onTap: () {
              final prodService = Provider.of<ProductsService>(context, listen: false);
              Navigator.pushNamed( context, 'detalleWeed' );
              prodService.producto = productos[i].prodName;   
            },
          );
        },
      )
    );
  }
}