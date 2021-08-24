
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data)  => json.encode(data.toJson());

class User {
    bool confirmed;
    bool blocked;
    String id;
    String username;
    String email;
    String idFavorite;

    User({
        this.confirmed,
        this.blocked,
        this.id,
        this.username,
        this.email,
        this.idFavorite,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        confirmed  : json["confirmed"],
        blocked    : json["blocked"],
        id         : json["_id"],
        username   : json["username"],
        email      : json["email"],
        idFavorite : json["idFavorite"],
    );

    Map<String, dynamic> toJson() => {
        "confirmed"  : confirmed,
        "blocked"    : blocked,
        "_id"        : id,
        "username"   : username,
        "email"      : email,
        "idFavorite" : idFavorite,
    };
}

class UserDB {
  String id;
  String token;
  String email;
  String username;
  String idFavorite;
  int isRemember;

  UserDB({
      this.id,
      this.token,
      this.email,
      this.username,
      this.idFavorite,
      this.isRemember,
  });

  factory UserDB.fromJson(Map<String, dynamic> json) => UserDB(
      id         : json["_id"],
      token      : json["token"], 
      email      : json["email"],
      username   : json["username"],
      idFavorite : json["idFavorite"],
      isRemember : json["isRemember"],
  );


  Map<String, dynamic> toJson() => {
        "_id"        : id,
        "username"   : username,
        "email"      : email,
        "token"      : token,
        "idFavorite" : idFavorite,
        "isRemember" : isRemember,
    };
  
}
