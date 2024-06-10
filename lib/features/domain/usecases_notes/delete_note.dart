import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart';
import '../repositories/note_repositories.dart';

class DeleteNoteUsecase {
  final NoteRepositories noteRepositories;
  DeleteNoteUsecase({
    required this.noteRepositories,
  });

  Future<Either<Failure, Unit>> call(String noteId) async {
    return await noteRepositories.deleteNoteModel(noteId);
  }
}
