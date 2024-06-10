import 'package:dartz/dartz.dart';
import '/features/data/model/note_model.dart';

import '../../domain/repositories/note_repositories.dart';

import '../../../core/util/util.dart';

import '../datasources/local/note_local_data_source.dart';


class NoteRepositoriesImpl implements NoteRepositories {
  final NoteLocalDataSourse noteLocalDataSourse;

  NoteRepositoriesImpl({
    required this.noteLocalDataSourse,
  });

  @override
  Future<Either<Failure, List<NoteModel>>> getAllNoteModel() async {
    
    try {
      final response = await noteLocalDataSourse.getAllNoteModel();
      
      return Right(response.cast<NoteModel>());
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, NoteModel>> getNoteModelById(String noteId) async {
    try {
      final response = await noteLocalDataSourse.getNoteModelById(noteId);
      return Right(response as NoteModel);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addNoteModel(NoteModel note) async {
    try {
      if (note.title.isEmpty && note.content.isEmpty) {
        return Left(EmpytInputFailure());
      } else {
        final NoteModel convertToNoteModel = NoteModel(
          id: note.id,
          title: note.title,
          content: note.content,
          colorIndex: note.colorIndex,
          modifiedTime: note.modifiedTime,
          stateNote: note.stateNote,
        );
        await noteLocalDataSourse.addNoteModel(convertToNoteModel);
        return const Right(unit);
      }
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNoteModel(NoteModel note) async {
    try {
      final NoteModel convertToNoteModel = NoteModel(
        id: note.id,
        title: note.title,
        content: note.content,
        colorIndex: note.colorIndex,
        modifiedTime: note.modifiedTime,
        stateNote: note.stateNote,
      );
      await noteLocalDataSourse.updateNoteModel(convertToNoteModel);
      return const Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNoteModel(String noteId) async {
    try {
      await noteLocalDataSourse.deleteNoteModel(noteId);
      return const Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }
  
  
}
