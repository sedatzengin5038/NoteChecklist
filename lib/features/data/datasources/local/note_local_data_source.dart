import 'package:dartz/dartz.dart';
import '/features/data/model/note_model.dart';




abstract class NoteLocalDataSourse {
  Future<bool> initDb();
  Future<List<NoteModel>> getAllNoteModel();
  Future<NoteModel> getNoteModelById(String noteModelById);
  Future<Unit> addNoteModel(NoteModel noteModel);
  Future<Unit> updateNoteModel(NoteModel noteModel);
  Future<Unit> deleteNoteModel(String noteModelId);
}
