import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notepadwithgetx/models/note_model.dart';
import 'package:notepadwithgetx/screen/Note_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(NoteModelAdapter());

  await Hive.openBox('notes');
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
