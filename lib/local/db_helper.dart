import 'dart:ffi';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class DbHelper {

  /// singleton
  DbHelper._();

  static final DbHelper getInstance = DbHelper._();

  //table note
  static final String TABLE_NOTE ="note";

  static final String COLUMN_NOTE_S_NO = "sno";
  static final String COLUMN_NOTE_TITLE ="title";
  static final String COLUMN_NOTE_DESC ="desc";



  Database ? myDB;
//db open (path ->if exists then open else create db)
  Future<Database> getDB() async
  {
    /*if(myDB != null)
      {
        return myDB!;
      }else
        {
         myDB = await OpenDB();
         return myDB;
        }*/


    myDB =  myDB ?? await OpenDB();
    return myDB!;
  }

  Future<Database> OpenDB()
  async {
    Directory appDir = await  getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path,"note.db");

  return await openDatabase(dbPath,onCreate: ( db, version)
    {
     db.execute("CREATE TABLE  $TABLE_NOTE ($COLUMN_NOTE_S_NO INTEGER PRIMARY KEY AUTOINCREMENT, "
         "$COLUMN_NOTE_TITLE text , $COLUMN_NOTE_DESC varchar(500))");

    },version: 1);

  }

//all query insertion
  Future<bool> addnote({ required String mtitle, required String mDesc}) async
  {
    var db= await getDB();
   int rowsEffected =await db.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: mtitle,
      COLUMN_NOTE_DESC:mDesc
    });
    return rowsEffected>0;
  }

  Future<bool> updatenote({ required String mtitle, required String mDesc,required int sno}) async
  {
    var db= await getDB();
    int rowsEffected =await db.update(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: mtitle,
      COLUMN_NOTE_DESC:mDesc ,
    } ,where:"$COLUMN_NOTE_S_NO=$sno" );
    return rowsEffected>0;
  }


  Future<bool> deleteNote({required int sno}) async
  {
    var db= await getDB();
    int rowsEffected = await db.delete(TABLE_NOTE,where: "$COLUMN_NOTE_S_NO= ?" ,
        whereArgs: ['$sno']);
    return rowsEffected>0;

 /*   int rowsEffected = await db.delete(TABLE_NOTE,where: "$COLUMN_NOTE_S_NO= ? ,$COLUMN_NOTE_TITLE =?" ,
        whereArgs: ['$sno','$title']);
*/
  }

//reading all data
 Future<List<Map<String , dynamic>>>  getAllnotes() async{
    var db= await getDB();
///select * from note
    List<Map<String , dynamic>> mData= await db.query(TABLE_NOTE);//(TABLE_NOTE ,Columns:[] or whereArgs) also use if add columns or where condition

    return mData;
 }

}