import 'package:flutter/material.dart';
import 'package:note_using_dbp/local/db_provider.dart';
import 'package:provider/provider.dart';

import 'add_note_page.dart';
import 'db_helper.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController =TextEditingController();
  TextEditingController descController =TextEditingController();

  List<Map<String , dynamic>> allNotes=[];
  DbHelper? dbRef;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   context.read<DbProvider>().getInitialNotes();
  }

  /*void getNotes() async
  {
   allNotes= await dbRef!.getAllnotes();
   setState(() {

   });
  }*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("note"),
      ),
      //all notes viewed here
      body:Consumer<DbProvider>(builder: (ctx,provider, __){
            List<Map<String, dynamic>> allNotes = provider.getNotes();
        return allNotes.isNotEmpty ? ListView.builder(
            itemCount: allNotes.length
            , itemBuilder: (_, index) {
          return ListTile(
            leading: Text('${allNotes[index][DbHelper.COLUMN_NOTE_S_NO]}'),
            title: Text(allNotes[index][DbHelper.COLUMN_NOTE_TITLE]),
            subtitle: Text(allNotes[index][DbHelper.COLUMN_NOTE_DESC]),
            trailing: SizedBox(
              width: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>
                          AddNotePage(isUpdate: true, sno:
                          allNotes[index][DbHelper.COLUMN_NOTE_S_NO],
                            title: allNotes[index][DbHelper.COLUMN_NOTE_TITLE],
                            desc: allNotes[index][DbHelper
                                .COLUMN_NOTE_DESC],),));
                    }, child: Icon(Icons.edit),
                  ),
                  InkWell(
            onTap: () {
              context.read<DbProvider>().deleteNote(allNotes[index][DbHelper.COLUMN_NOTE_S_NO]);

            }, child: Icon(Icons.delete,color: Colors.red,),
          ),
                ],
              ),

            ),


          );
        }):Center(
          child: Text('No Notes yet!!'),
        );


    }
    ),


        floatingActionButton: FloatingActionButton(onPressed: () async{


          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNotePage(),));
    },
    child: Icon(Icons.add),

        ),
    );
  }
}




