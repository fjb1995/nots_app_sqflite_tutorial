import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class SqlDb{

  //*--*-**-* to ensure the database created and running *-*-*--*///
  static Database? _db ;
  Future<Database?> get db async{
    if(_db == null){
      _db = await initialDb();
      return _db;
    }else{
      return _db;
    }
  }

  // *-*-*-*-   Create Database Path on the mobile devise and set it's name*-*-*-*-*//
  initialDb() async {
    String databasePath = await getDatabasesPath();   // create database path
    String path = join(databasePath, 'notes.db');     // choose database name and joined it with the path (databasePath/databaseName)

    //*-*-**-*-  Creating database *--*-*-*///
    Database myDb = await openDatabase(path, onCreate: _onCreate, version: 4, onUpgrade: _onUpgrade);
    return myDb;
  }

  //*-*-*-*-- onCreate function (Create Database)  **-*-**-*-*//
  _onCreate(Database db, int version) async {

    //  We can create many tables when using the Batch function
    Batch batch =db.batch();   //   to create more than one table

    //*-*-***- Creating each Table *-*-*-**-//
    batch.execute('''
    CREATE TABLE "notes" (
      'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      'title'   TEXT NOT NULL,
      'note' TEXT NOT NULL
    )
    ''');
    // ---------------------------------------------------//
    await batch.commit();     // to execution the tables when use the Batch function
    print(' Database and tables created ======================');
  }

  //*-*-*-*-- onUpgrade function (Upgrade Database)  **-*-**-*-*//
  _onUpgrade(Database db, int oldVersion, int newVersion) async{
    await db.execute("ALTER TABLE notes ADD COLUMN color TEXT");
    print(' Database Upgraded ======================');
  }

  //*-*-*-*-*-  Select data from database *-*--*-*-*//
  readData(String sql) async{
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  //*-*-*-*-*-  Insert data to database *-*--*-*-*//
  insertData(String sql) async{
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  //*-*-*-*-*-  Update database *-*--*-*-*//
  updateData(String sql) async{
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  //*-*-*-*-*-  Delete data from database *-*--*-*-*//
  deleteData(String sql) async{
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }



  //*-*-*-*-*-  Delete Database *-*--*-*-*//
  deleteDb() async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'notes.db');
    await deleteDatabase(path);
  }


  //*-*-*-*-*-  Select data from database *-*--*-*-*//
  read(String table) async{
    Database? myDb = await db;
    List<Map> response = await myDb!.query(table);
    return response;
  }

  //*-*-*-*-*-  Insert data to database *-*--*-*-*//
  insert(String table, Map<String, Object?> values) async{
    Database? myDb = await db;
    int response = await myDb!.insert(table, values);
    return response;
  }

  //*-*-*-*-*-  Update database *-*--*-*-*//
  update(String table, Map<String, Object?> values, String? myWhere) async{
    Database? myDb = await db;
    int response = await myDb!.update(table, values, where: myWhere);
    return response;
  }

  //*-*-*-*-*-  Delete data from database *-*--*-*-*//
  delete(String table, String? myWhere) async{
    Database? myDb = await db;
    int response = await myDb!.delete(table, where: myWhere);
    return response;
  }
}