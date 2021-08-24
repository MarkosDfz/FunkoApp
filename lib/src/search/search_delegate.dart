
import 'package:coffishop/src/models/categories_model.dart';
import 'package:coffishop/src/services/products_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataSearch extends SearchDelegate {

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Color(0xff262A2D),
      primaryIconTheme: theme.primaryIconTheme.copyWith( color: Colors.white ),
      primaryColorBrightness: Brightness.dark,
    );
  }

    @override
    String get searchFieldLabel => "¿Qué estas buscando?";


  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de el Appbar (ejm botones para poder limpiar o cancelar)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        }
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del Appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation
      ),
      onPressed: () {
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que se muestran al escribir

    final prodService = Provider.of<ProductsService>(context);

        if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: prodService.buscarProducts(query),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        
        if (snapshot.hasData) {

          final productos = snapshot.data;

          return ListView.separated(
            itemCount: productos.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: ( BuildContext context, int index ) {
              return Container(
                child: ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage('assets/load.gif'),
                    image: NetworkImage(productos[index].prodImagePath),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(productos[index].prodName),
                  subtitle: Text(productos[index].prodType),
                  onTap: () {
                    final prodService = Provider.of<ProductsService>(context, listen: false);
                    close(context, null);
                    Navigator.pushNamed( context, 'detalleWeed' );
                    prodService.producto = productos[index].prodName;
                  },
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  
}