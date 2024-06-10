import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/features/data/model/note_model.dart';

import '../../../../core/core.dart';

part 'status_icons_state.dart';

class StatusIconsCubit extends Cubit<StatusIconsState> {
  StatusIconsCubit() : super(StatusIconsInitial());

  NoteModel _currentNote = NoteModel.empty();
  StateNote _currentNoteStatus = StateNote.undefined;
  ArchiveStatus _currentArchiveStatus = ArchiveStatus.unarchive;
  final StateNote _isTrashInNote = StateNote.trash;

  void toggleIconsStatus(NoteModel currentNote) {
    _currentNote = currentNote;
    _currentNoteStatus = currentNote.stateNote;
    _currentArchiveStatus = currentNote.stateNote == StateNote.archived
        ? ArchiveStatus.archive
        : ArchiveStatus.unarchive;

    if (_isTrashInNote == _currentNoteStatus) {
      return emit(ReadOnlyState(_currentNote));
    } else {
      return emit(
        ToggleIconsStatusState(
          currentNote: _currentNote,
          currentArchiveStatus: _currentArchiveStatus,
          currentNoteStatus: _currentNoteStatus,
        ),
      );
    }
  }

  void toggleIconPinnedStatus(StateNote currentStatus) {
    _currentNoteStatus = currentStatus == StateNote.pinned
        ? StateNote.undefined
        : StateNote.pinned;
    emit(
      ToggleIconsStatusState(
        currentNote: _currentNote,
        currentNoteStatus: _currentNoteStatus,
        currentArchiveStatus: _currentArchiveStatus,
      ),
    );
  }
}
