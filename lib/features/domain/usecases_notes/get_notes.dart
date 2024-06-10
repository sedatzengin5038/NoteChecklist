import 'package:dartz/dartz.dart';
import '/features/data/model/note_model.dart';

import '../../../core/util/util.dart';

import '../repositories/note_repositories.dart';

class GetNotesUsecase {
  final NoteRepositories noteRepositories;

  GetNotesUsecase({
    required this.noteRepositories,
  });

  Future<Either<Failure, List<NoteModel>>> call() async {
    //await Future.delayed(const Duration(seconds: 2));
    
    return await noteRepositories.getAllNoteModel();
  }
}
