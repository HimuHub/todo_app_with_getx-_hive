import 'package:hive/hive.dart';
part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {
  @HiveField(0)
  String Time;
  @HiveField(1)
  String Title;
  @HiveField(2)
  String Discription;

  NoteModel(this.Title, this.Time, this.Discription);
}
