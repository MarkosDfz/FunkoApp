
import 'dart:convert';

import 'package:coffishop/src/models/categories_model.dart';

Fav favFromJson(String str) => Fav.fromJson(json.decode(str));

String favToJson(Fav data)  => json.encode(data.toJson());

class Fav {
    List<Product> idProducts;
    String idUser;

    Fav({
        this.idProducts,
        this.idUser,
    });

    factory Fav.fromJson(Map<String, dynamic> json) => Fav(
        idProducts : List<Product>.from(json["idProducts"].map((x) => Product.fromJson(x))),
        idUser     : json["idUser"],
    );

    Map<String, dynamic> toJson() => {
        "idProducts" : List<dynamic>.from(idProducts.map((x) => x.toJson())),
        "idUser"     : idUser,
    };
}
