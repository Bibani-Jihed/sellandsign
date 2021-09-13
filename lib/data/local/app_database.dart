import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sellandsign/data/local/constants/db_constants.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {

  //we only need one instance of this class
  static final AppDatabase _singleton = AppDatabase._internal();
  factory AppDatabase() {
    return _singleton;
  }
  AppDatabase._internal();

  //database
  Database? _db;

  //also we need one instance of _db
  Future<Database?> get database async {
    if (_db != null) return _db;
    // if _database is null we instantiate it
    return _db = await init();
  }

  //create Contractor Table
  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DBConstants.DB_NAME);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE ${DBConstants.CONTRACTOR_TABLE} ("
              "${DBConstants.ID} INTEGER PRIMARY KEY,"
              "${DBConstants.CIVILITY} TEXT,"
              "${DBConstants.FIRSTNAME} TEXT,"
              "${DBConstants.LASTNAME} TEXT,"
              "${DBConstants.ADDRESS_1} TEXT,"
              "${DBConstants.ADDRESS_2} TEXT,"
              "${DBConstants.POSTAL_CODE} TEXT,"
              "${DBConstants.CITY} TEXT,"
              "${DBConstants.CELL_PHONE} TEXT,"
              "${DBConstants.EMAIL} TEXT"
              ")");
        });
  }
}
