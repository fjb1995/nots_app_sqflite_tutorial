import 'package:flutter/material.dart';
import 'addnotes.dart';
import 'my_app.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyApp(),
      routes: {"addnotes" : (context) => const AddNotes()},
  ),
  );
}