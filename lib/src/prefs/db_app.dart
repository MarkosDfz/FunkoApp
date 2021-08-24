
import 'dart:io';
import 'package:coffishop/src/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {

    if ( _database != null ) return _database;

    _database = await initDB();

    return _database;

  }

  initDB() async {

    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join( documentDirectory.path, 'ToyDB.db' );

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: ( Database db, int version ) async {
        await db.execute(
          'CREATE TABLE Users('
          ' _id TEXT PRIMARY KEY,'
          ' token TEXT,'
          ' isRemember INTEGER,'
          ' email TEXT,'
          ' idFavorite TEXT,'
          ' username TEXT'
          ')'
        );
      }
    );

  }

  // CREAR REGISTROS
  nuevoUsuario( UserDB nuevoUser ) async {

    final db = await database;
    final res = await db.insert('Users', nuevoUser.toJson());
    return res;

  }

  // SELECT - OBTENER INFORMACIÓN
  Future<UserDB> getUser() async {

    final db = await database;

    final res = await db.query('Users');

    return res.isNotEmpty ? UserDB.fromJson(res.first) : null;

  }

  // ELIMINAR REGISTROS
  Future deleteAll() async {

    final db = await database;
    final res = await db.rawDelete('DELETE FROM Users');
    return res;

  }

}