
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

void mostarAlerta( BuildContext context, String titulo, String mensaje, Widget acc1, [ Widget acc2 ] ) {

  showDialog(
    context: context,
    builder: ( context ) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular( 30.0 )
        ),
        title: Text( titulo ),
        content: Text( mensaje, style: TextStyle( color: Colors.white70) ),
        actions: <Widget>[
          acc2,
          acc1,
        ],
      );
    }
  );

}

 Future<bool> checkNetwork() async {
   
  bool respuesta = false;

  final result = await Connectivity().checkConnectivity();

  if (result != ConnectivityResult.none) {
    respuesta = true;
  } else {
    respuesta = false;
  }
  return respuesta;

}