import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive/hive.dart';
import 'package:notepadwithgetx/models/note_model.dart';

class NoteController extends GetxController {
  final Box box = Hive.box('notes');
  void createNote(NoteModel note) {
    box.add(note);
  }

  void updatenote(NoteModel note, index) {
    box.putAt(index, note);
  }

  void noteDelete(index) {
    box.deleteAt(index);
  }
}
