
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:coffishop/src/models/categories_model.dart';
import 'package:coffishop/src/services/products_service.dart';
import 'package:coffishop/src/widgets/products_list_widget.dart';

class CategoriesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final String categoryName = ModalRoute.of(context).settings.arguments;
    final prodService = Provider.of<ProductsService>(context);
    final List<Product> productos = prodService.productosCategorias;

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
          title: Text( categoryName ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.all( 5.0 ),
          child: ProductsList( productos: productos )
        ),
      ),
    );

  }

}

