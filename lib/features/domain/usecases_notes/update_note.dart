import 'package:dartz/dartz.dart';
import '/features/data/model/note_model.dart';
import '/core/util/errors/failure.dart';

import '../../../core/util/util.dart';
import '../repositories/note_repositories.dart';

class UpdateNoteUsecase {
  final NoteRepositories noteRepositories;

  UpdateNoteUsecase({
    required this.noteRepositories,
  });

  Future<Either<Failure, Unit>> call(NoteModel note) async {
    return await noteRepositories.updateNoteModel(note);
  }
}
