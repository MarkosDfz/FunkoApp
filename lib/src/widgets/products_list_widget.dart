
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:coffishop/src/models/categories_model.dart';
import 'package:coffishop/src/services/products_service.dart';
import 'package:coffishop/src/widgets/productos_card_widget.dart';

class ProductsList extends StatelessWidget {
  ProductsList({
    @required this.productos, 
  });

  final List<Product> productos;
  final _pageController = new PageController();

  @override
  Widget build(BuildContext context) {

    var _size = MediaQuery.of(context).size;
    final double itemHeight = 300.0;
    final double itemWidth = _size.width / 2;
    
    return GridView.builder(
      controller: _pageController,
      itemCount: productos.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (itemWidth / itemHeight),
        crossAxisCount: 2
      ),
      itemBuilder: ( BuildContext context, int i ) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            child: ProductosCard(
              productos: productos,
              index: i,
              mostrarPrecio: true,
            ),
            onTap: () {
              final prodService = Provider.of<ProductsService>(context, listen: false);
              Navigator.pushNamed( context, 'detalleWeed' );
              prodService.producto = productos[i].prodName;
            },
          ),
        );
      }
    );
  }
}