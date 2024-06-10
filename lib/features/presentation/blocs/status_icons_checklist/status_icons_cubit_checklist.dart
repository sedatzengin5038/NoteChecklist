import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterkeepme/core/config/enum/status_Checklist.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';


import '../../../../core/core.dart';

part 'status_icons_state_checklist.dart';

class StatusIconsCubitChecklist extends Cubit<StatusIconsStateChecklist> {
  StatusIconsCubitChecklist() : super(StatusIconsInitialChecklist());

  ChecklistModel _currentChecklist = ChecklistModel.empty();
  StateChecklist _currentChecklistStatus = StateChecklist.undefined;
  ArchiveStatus _currentArchiveStatus = ArchiveStatus.unarchive;
  final StateChecklist _isTrashInChecklist = StateChecklist.trash;

  void toggleIconsStatusChecklist(ChecklistModel currentChecklist) {
    _currentChecklist = currentChecklist;
    _currentChecklistStatus = currentChecklist.stateChecklist;
    _currentArchiveStatus = currentChecklist.stateChecklist == StateChecklist.archived
        ? ArchiveStatus.archive
        : ArchiveStatus.unarchive;

    if (_isTrashInChecklist == _currentChecklistStatus) {
      return emit(ReadOnlyStateChecklist(_currentChecklist));
    } else {
      return emit(
        ToggleIconsStatusStateChecklist(
          currentChecklist: _currentChecklist,
          currentArchiveStatus: _currentArchiveStatus,
          currentChecklistStatus: _currentChecklistStatus,
        ),
      );
    }
  }

  void toggleIconPinnedStatus(StateChecklist currentStatus) {
    _currentChecklistStatus = currentStatus == StateChecklist.pinned
        ? StateChecklist.undefined
        : StateChecklist.pinned;
    emit(
      ToggleIconsStatusStateChecklist(
        currentChecklist: _currentChecklist,
        currentChecklistStatus: _currentChecklistStatus,
        currentArchiveStatus: _currentArchiveStatus,
      ),
    );
  }
}
