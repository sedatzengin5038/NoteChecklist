import 'package:dartz/dartz.dart';
import '/features/data/model/note_model.dart';

import '../../../core/util/util.dart';

import '../repositories/note_repositories.dart';

class AddNoteUsecase {
  final NoteRepositories noteRepositories;
  AddNoteUsecase({
    required this.noteRepositories,
  });

  Future<Either<Failure, Unit>> call(NoteModel note) async {
    return await noteRepositories.addNoteModel(note);
  }
}
