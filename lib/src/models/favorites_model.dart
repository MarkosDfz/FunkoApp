
import 'dart:convert';

import 'package:coffishop/src/models/user_model.dart';
import 'package:coffishop/src/models/categories_model.dart';

Favorites favoritesFromJson(String str) => Favorites.fromJson(json.decode(str));

String favoritesToJson(Favorites data)  => json.encode(data.toJson());

class Favorites {
    String id;
    User idUser;
    List<Product> idProducts;
    String favoritesId;

    Favorites({
        this.id,
        this.idUser,
        this.idProducts,
        this.favoritesId,
    });

    factory Favorites.fromJson(Map<String, dynamic> json) => Favorites(
        id          : json["_id"],
        idUser      : User.fromJson(json["idUser"]),
        idProducts  : List<Product>.from(json["idProducts"].map((x) => Product.fromJson(x))),
        favoritesId : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id"        : id,
        "idProducts" : List<dynamic>.from(idProducts.map((x) => x.toJson())),
        "id"         : favoritesId,
        "idUser"     : idUser.toJson(),
    };
}