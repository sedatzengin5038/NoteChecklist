part of 'status_icons_cubit_checklist.dart';

sealed class StatusIconsStateChecklist extends Equatable {
  const StatusIconsStateChecklist();

  @override
  List<Object> get props => [];
}

final class StatusIconsInitialChecklist extends StatusIconsStateChecklist {}

final class ToggleIconsStatusStateChecklist extends StatusIconsStateChecklist {
  final ChecklistModel currentChecklist;
  final StateChecklist currentChecklistStatus;
  final ArchiveStatus currentArchiveStatus;

  const ToggleIconsStatusStateChecklist({
    required this.currentChecklist,
    required this.currentChecklistStatus,
    required this.currentArchiveStatus,
  });

  @override
  List<Object> get props =>
      [currentArchiveStatus, currentChecklistStatus, currentChecklist];
}

final class ReadOnlyStateChecklist extends StatusIconsStateChecklist {
  final ChecklistModel currentChecklist;

  const ReadOnlyStateChecklist(this.currentChecklist);

  @override
  List<Object> get props => [currentChecklist];
}
