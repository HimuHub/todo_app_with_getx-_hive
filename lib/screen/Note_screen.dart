import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notepadwithgetx/controllers/note_controller.dart';
import 'package:notepadwithgetx/models/note_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NoteController noteController = Get.put(NoteController());
  TextEditingController titleClt = TextEditingController();
  TextEditingController timeClt = TextEditingController();
  TextEditingController discriptiontClt = TextEditingController();

  _showDialog(context) {
    return showDialog(
        context: context,
        builder: (context) => Center(
              child: SingleChildScrollView(
                child: AlertDialog(
                  alignment: Alignment.center,
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          noteController.createNote(NoteModel(titleClt.text,
                              timeClt.text, discriptiontClt.text));
                          Get.back();
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                  content: Column(
                    children: [
                      TextField(
                        controller: timeClt,
                        decoration: InputDecoration(hintText: 'Time'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: titleClt,
                        decoration: InputDecoration(hintText: 'Title'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: discriptiontClt,
                        decoration: InputDecoration(hintText: 'Description'),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  _showUpdateDialog(context, index) {
    return showDialog(
        context: context,
        builder: (context) => Center(
              child: SingleChildScrollView(
                child: AlertDialog(
                  alignment: Alignment.center,
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          noteController.updatenote(
                              NoteModel(titleClt.text, timeClt.text,
                                  discriptiontClt.text),
                              index);
                          Get.back();
                        },
                        child: Text(
                          'update',
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                  content: Column(
                    children: [
                      TextField(
                        controller: timeClt,
                        decoration: InputDecoration(hintText: 'Time'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: titleClt,
                        decoration: InputDecoration(hintText: 'Title'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: discriptiontClt,
                        decoration: InputDecoration(hintText: 'discription'),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  final Box box = Hive.box('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notepad"),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrangeAccent,
          child: Icon(Icons.add),
          onPressed: () {
            _showDialog(context);
          }),
      body: GetBuilder<NoteController>(
          builder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (context, Box, child) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: box.keys.length,
                          itemBuilder: (context, index) {
                            NoteModel note = box.getAt(index);
                            return Card(
                              child: ListTile(
                                leading: Text(note.id),
                                title: Text(note.name),
                                subtitle: Text(note.department),
                                trailing: Container(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            noteController.noteDelete(index);
                                          },
                                          icon: Icon(Icons.delete)),
                                      IconButton(
                                          onPressed: () {
                                            _showUpdateDialog(context, index);
                                          },
                                          icon: Icon(Icons.edit)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
              )),
    );
  }
}
