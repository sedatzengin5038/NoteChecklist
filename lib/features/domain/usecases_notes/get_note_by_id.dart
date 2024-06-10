import 'package:dartz/dartz.dart';
import '/features/data/model/note_model.dart';

import '../../../core/core.dart';

import '../repositories/note_repositories.dart';

class GetNoteByIdUsecase {
  final NoteRepositories noteRepositories;
  GetNoteByIdUsecase({
    required this.noteRepositories,
  });

  Future<Either<Failure, NoteModel>> call(String noteId) async {
    print(noteId);
    return await noteRepositories.getNoteModelById(noteId);
  }
}
