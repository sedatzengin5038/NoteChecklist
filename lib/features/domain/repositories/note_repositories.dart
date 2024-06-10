import 'package:dartz/dartz.dart';
import '/features/data/model/note_model.dart';
import '/core/util/errors/failure.dart';

abstract class NoteRepositories {
  Future<Either<Failure, List<NoteModel>>> getAllNoteModel();
  Future<Either<Failure, NoteModel>> getNoteModelById(String noteId);
  Future<Either<Failure, Unit>> addNoteModel(NoteModel note);
  Future<Either<Failure, Unit>> updateNoteModel(NoteModel note);
  Future<Either<Failure, Unit>> deleteNoteModel(String noteId);
}
