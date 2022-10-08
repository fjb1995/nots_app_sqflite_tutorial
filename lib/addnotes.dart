import 'package:flutter/material.dart';
import 'package:nots_app_sqflite_tutorial/my_app.dart';
import 'package:nots_app_sqflite_tutorial/sqldb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override

  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

  SqlDb sqldb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add note'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      width: double.infinity,
                      child: TextFormField(
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(height: 1.25),
                        controller: title,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration:InputDecoration(
                          prefixIcon: const Icon(Icons.title),
                          labelText: 'Title',
                          hintText: 'Input your Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )),


                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      width: double.infinity,
                      child: TextFormField(
                        textInputAction: TextInputAction.newline,
                        style: const TextStyle(height: 1.25),
                        controller: note,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        obscureText: false,
                        decoration:InputDecoration(
                          labelText: 'Note',
                          hintText: 'Input your note',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )),


                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      width: double.infinity,
                      child: TextFormField(
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(height: 1.25),
                        controller: color,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration:InputDecoration(
                          prefixIcon: const Icon(Icons.color_lens),
                          labelText: 'Color',
                          hintText: 'Input your Color',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )),


                  MaterialButton(
                    child: const Text('Add'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () async {
                      int response = await sqldb.insert('notes', {
                        'note': note.text,
                        'title': title.text,
                        'color': color.text,
                      });
                      if(response > 0){
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const MyApp()),
                                (route) => false);
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}