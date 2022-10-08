import 'package:flutter/material.dart';
import 'package:nots_app_sqflite_tutorial/editnotes.dart';
import 'package:nots_app_sqflite_tutorial/sqldb.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  SqlDb sqlDb = SqlDb();
  List notes = [];
  bool isLoading = true;

  Future readData() async{
    List<Map> response = await sqlDb.read("notes");
    notes.addAll(response);
    isLoading = false;
    if(mounted){
      setState(() {

      });
    }
  }


  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoteBook'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
      ),

      body: isLoading == true?
          const Center(child: Text('Loading...'))
      : Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, i){
                    return Card(
                      child: ListTile(
                        title: Text('${notes[i]['title']}'),
                        subtitle: Text('${notes[i]['note']}'),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            //*-*-*-*---*-  Delete note Button *-*-*-*-*-*//
                            IconButton(
                              onPressed: () async {
                                // *-*-**-  Delete Row form Database  *-*-*-*-//
                                int response = await sqlDb.delete('notes', 'id = ${notes[i]['id']}');

                                // *-*-**-  Delete Row form UI  *-*-*-*-//
                                // *-*-**-  if response > 0 that means that the row is deleted  *-*-*-*-//
                                if(response > 0) {
                                  setState(() {
                                    notes.removeWhere((element) => element['id'] == notes[i]['id']);
                                  });
                                }
                              },
                              icon: const Icon(Icons.delete, color: Colors.red,),
                            ),

                            //*-*-*-*---*-  Edit note Button *-*-*-*-*-*//
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => EditNotes(
                                      note: notes[i]['note'],
                                      title: notes[i]['title'],
                                      id: notes[i]['id'],
                                      color: notes[i]['color']
                                  ))
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),)
                          ],
                        )
                      ),
                    );
                  }),
      )
    );
  }
}
