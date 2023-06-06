import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class SqliteDatabase {
  Map<int, String> scripts = {
    1: ''' CREATE TABLE pessoa (
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         nome TEXT,
         altura DOUBLE
      ) ''',
    2: ''' CREATE TABLE informacao (
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         peso DOUBLE,
         idpessoa INTEGER,
         FOREIGN KEY(idpessoa) REFERENCES pessoa(id) ON DELETE CASCADE
      ) '''
  };

  static Database? db;

  Future<Database> obterDatabase() async {
    if (db == null) {
      return await iniciarDB();
    } else {
      return db!;
    }
  }

  Future iniciarDB() async {
    var db = openDatabase(
      path.join(await getDatabasesPath(), 'db.db'),
      version: scripts.length,
      onCreate: (db, version) async {
        for (var i = 1; i <= scripts.length; i++) {
          await db.execute(scripts[i]!);
          print("Atualização banco de dados ($version)");
        }
        print("Versão atual do banco de dados: $version");
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (var i = oldVersion + 1; i <= scripts.length; i++) {
          await db.execute(scripts[i]!);
          print("Atualização banco de dados ($oldVersion)");
        }
        print("Versão atual do banco de dados: $newVersion");
      },
    );

    return db;
  }
}
