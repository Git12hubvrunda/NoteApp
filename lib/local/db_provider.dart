
import 'package:flutter/material.dart';

import 'db_helper.dart';


class DbProvider extends ChangeNotifier{

  DbHelper dbHelper;
  DbProvider({required this.dbHelper});
  List<Map<String , dynamic>> _mData=[];

  void addNote(String title,String desc) async
  {
    bool check = await dbHelper.addnote(mtitle: title, mDesc: desc);
    if(check)
      {
      _mData= await dbHelper.getAllnotes();
      notifyListeners();
      }
  }

  void updateNote(String title,String desc,int sno) async
  {
    bool check = await dbHelper.updatenote(mtitle: title, mDesc: desc,sno:sno);
    if(check)
    {
      _mData= await dbHelper.getAllnotes();
      notifyListeners();
    }
  }

  void deleteNote(int sno) async
  {
    bool check = await dbHelper.deleteNote(sno: sno);
    if(check)
    {
      _mData= await dbHelper.getAllnotes();
      notifyListeners();
    }
  }


  List<Map<String,dynamic>> getNotes() => _mData;

  void getInitialNotes() async{
    _mData= await dbHelper.getAllnotes();
    notifyListeners();
  }
}
