

import 'package:flutter/material.dart';
import 'package:note_using_dbp/local/db_provider.dart';
import 'package:provider/provider.dart';

import 'db_helper.dart';

class AddNotePage extends StatelessWidget {

  bool isUpdate;
  String title;
  String desc;
  int sno;
bool isDelete;

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  //DbHelper? dbRef = DbHelper.getInstance;

  AddNotePage({this.isDelete=false,this.isUpdate = false,this.sno = 0,this.title = "",this.desc = ""});

  @override
  Widget build(BuildContext context) {

    if(isUpdate)
    {
      titleController.text=title;
      descController.text=desc;


    }


    return Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? 'update Note':'Add note'),
        ),
        body:
        Container(
          padding: EdgeInsets.all(11),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 21,
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  label: Text('Title *'),
                  hintText: "Enter title here",

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),

                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
              SizedBox(
                height: 21,
              ),
              TextField(
                controller: descController,
                maxLines: 4,
                decoration: InputDecoration(
                  label: Text('Desc *'),
                  hintText: "Enter Desc here",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),

                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
              SizedBox(
                height: 21,
              ),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(

                            side: BorderSide(
                                width: 1
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11)
                            )
                        ),

                        onPressed: () async{
                          var title= titleController.text;
                          var Des = descController.text;

                          if(title.isNotEmpty && Des.isNotEmpty)
                          {
                            bool check;
                            if(isUpdate)
                              {
                              /*  check = await dbRef!.updatenote(
                                    mtitle: title, mDesc: Des,sno: sno);*/
                                context.read<DbProvider>().updateNote(title, Des, sno);

                              }else
                              {
                                context.read<DbProvider>().addNote(title, Des);


                              /* check = await dbRef!.addnote(
                                   mtitle: title, mDesc: Des);*/
                            }
                                Navigator.pop(context);


                          }
                          else{



                            ScaffoldMessenger.of(context).showSnackBar(SnackBar( content:Text('fill all details')));
                          }

                        },
                        child: Text(isUpdate ? 'update Note':'Add note')),
                  ),

                  SizedBox(
                    width: 11,
                  ),

                  Expanded(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(

                            side: BorderSide(
                                width: 1
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11)
                            )
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text('Cancel')),
                  )
                ],
              ),
              // Text("Write details")
            ],
          ),

        )
    );
  }
}




