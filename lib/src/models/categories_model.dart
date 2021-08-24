
import 'dart:convert';
import 'package:equatable/equatable.dart';

List<Categories> categoriesFromJson(String str) => List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data)  => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
    String id;
    String description;
    List<Product> products;
    String categoryId;

    Categories({
        this.id,
        this.description,
        this.products,
        this.categoryId,
    });

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id          : json["_id"],
        description : json["description"],
        products    : List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        categoryId  : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "description": description,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "id": categoryId,
    };
}

class Products {

  List<Product> items = new List();

  Products();

  Products.fromJsonList( List<dynamic> jsonList ) {

    if ( jsonList == null ) return;

    for (var item in jsonList) {
      final product = new Product.fromJson(item);
      items.add(product);
    }

  }
}

class Product extends Equatable {
    final String id;
    final String prodImagePath;
    final String prodName;
    final double prodPrice;
    final int prodQuantity;
    final bool prodAvilable;
    final String prodDescription;
    final String prodType;
    final String productId;
    final String cbd;
    final String thc;

    Product({
        this.id,
        this.prodImagePath,
        this.prodName,
        this.prodPrice,
        this.prodQuantity,
        this.prodAvilable,
        this.prodDescription,
        this.prodType,
        this.productId,
        this.cbd,
        this.thc,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id              : json["_id"],
        prodImagePath   : json["prodImagePath"],
        prodName        : json["prodName"],
        prodPrice       : json["prodPrice"].toDouble(),
        prodQuantity    : json["prodQuantity"],
        prodAvilable    : json["prodAvilable"],
        prodDescription : json["prodDescription"],
        prodType        : json["prodType"],
        productId       : json["id"],
        cbd             : json["cbd"] == null ? null : json["cbd"],
        thc             : json["thc"] == null ? null : json["thc"],
    );

    Map<String, dynamic> toJson() => {
        "_id"             : id,
        "prodImagePath"   : prodImagePath,
        "prodName"        : prodName,
        "prodPrice"       : prodPrice,
        "prodQuantity"    : prodQuantity,
        "prodAvilable"    : prodAvilable,
        "prodDescription" : prodDescription,
        "prodType"        : prodType,
        "id"              : productId,
        "cbd"             : cbd == null ? null : cbd,
        "thc"             : thc == null ? null : thc,
    };

    @override
  List<Object> get props => [ id, prodImagePath, prodName, prodPrice,
                              prodQuantity, prodAvilable, prodDescription,
                              prodType, productId, cbd, thc ];
}
