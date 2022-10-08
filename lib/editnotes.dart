import 'package:flutter/material.dart';
import 'package:nots_app_sqflite_tutorial/my_app.dart';
import 'package:nots_app_sqflite_tutorial/sqldb.dart';

class EditNotes extends StatefulWidget {
  final String note;
  final String title;
  final String color;
  final int id;

  const EditNotes({Key? key, required this.note, required this.title, required this.id, required this.color}) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {

  SqlDb sqldb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit note'),
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
                    child: const Text('Edit'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () async {
                      int response = await sqldb.update('notes',{
                        'note' : note.text,
                        'color' : color.text,
                        'title' : title.text
                      },
                      'id = ${widget.id}'
                      );
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