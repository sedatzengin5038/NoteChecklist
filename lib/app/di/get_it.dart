import 'package:flutterkeepme/features/data/datasources/local/checklist_local_data_source.dart';
import 'package:flutterkeepme/features/data/datasources/local/firebase/checklist_local_data_source_with_firebase_impl.dart';
import 'package:flutterkeepme/features/data/repositories/repositories_implChecklist.dart';
import 'package:flutterkeepme/features/domain/repositories/checklist_repositories.dart';
import 'package:flutterkeepme/features/domain/usecases_checklist/add_checklist.dart';
import 'package:flutterkeepme/features/domain/usecases_checklist/delete_checklist.dart';
import 'package:flutterkeepme/features/domain/usecases_checklist/get_checklist.dart';
import 'package:flutterkeepme/features/domain/usecases_checklist/get_checklist_by_id.dart';
import 'package:flutterkeepme/features/domain/usecases_checklist/update_checklist.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';

import '/features/data/datasources/local/firebase/note_local_data_source_with_firebase_impl.dart';
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/data/datasources/local/note_local_data_source.dart';
import '../../features/data/repositories/repositories_implNote.dart';
import '../../features/domain/repositories/note_repositories.dart';
import '../../features/domain/usecases_notes/add_note.dart';
import '../../features/domain/usecases_notes/delete_note.dart';
import '../../features/domain/usecases_notes/get_note_by_id.dart';
import '../../features/domain/usecases_notes/get_notes.dart';
import '../../features/domain/usecases_notes/update_note.dart';
import '../../features/presentation/blocs/blocs.dart';

final gI = GetIt.I;

Future<void> init() async {

  gI.registerFactory(
    () => ChecklistBloc(
      getChecklists: gI(),
      getChecklistById: gI(),
      addChecklist: gI(),
      updateChecklist: gI(),
      deleteChecklist: gI(),
    ),
  );
  
  //=> BloC //
  gI.registerFactory(
    () => NoteBloc(
      getNotes: gI(),
      getNoteById: gI(),
      addNote: gI(),
      updateNote: gI(),
      deleteNote: gI(),
    ),
  );

  

  gI.registerFactory(() => StatusIconsCubit());
  gI.registerFactory(() => StatusGridCubit());
  gI.registerFactory(() => StatusIconsCubitChecklist());
  gI.registerFactory(() => ProfileCubit(sharedPreferences: gI()));
  gI.registerFactory(() => ThemeCubit(sharedPreferences: gI()));
  gI.registerFactory(() => SearchCubit(getNotes: gI()));

  //=> Usecases
  gI.registerLazySingleton(() => GetNotesUsecase(noteRepositories: gI()));
  gI.registerLazySingleton(() => GetNoteByIdUsecase(noteRepositories: gI()));
  gI.registerLazySingleton(() => AddNoteUsecase(noteRepositories: gI()));
  gI.registerLazySingleton(() => UpdateNoteUsecase(noteRepositories: gI()));
  gI.registerLazySingleton(() => DeleteNoteUsecase(noteRepositories: gI()));

  gI.registerLazySingleton(() => GetChecklistsUsecase(checklistRepositories: gI()));
  gI.registerLazySingleton(() => GetChecklistByIdUsecase(checklistRepositories: gI()));
  gI.registerLazySingleton(() => AddChecklistUsecase(checklistRepositories: gI()));
  gI.registerLazySingleton(() => UpdateChecklistUsecase(checklistRepositories: gI()));
  gI.registerLazySingleton(() => DeleteChecklistUsecase(checklistRepositories: gI()));

  //=> Repository
  gI.registerLazySingleton<NoteRepositories>(
    () => NoteRepositoriesImpl(noteLocalDataSourse: gI()),
  );

  gI.registerLazySingleton<ChecklistRepositories>(
    () => ChecklistRepositoriesImpl(checklistLocalDataSource: gI()),
  );

  //=> Datasourse
  gI.registerLazySingleton<NoteLocalDataSourse>(
    () => NoteLocalDataSourceWithFirestoreImpl(),
  );

  

  gI.registerLazySingleton<ChecklistLocalDataSource>(
    () => ChecklistLocalDataSourceWithFirestoreImpl(),
  );

  await gI<ChecklistLocalDataSource>().initDb();
  
  await gI<NoteLocalDataSourse>().initDb();
  //! Core !//
  //! External!//
  final sharedPreferences = await SharedPreferences.getInstance();
  gI.registerLazySingleton(() => sharedPreferences);
}
