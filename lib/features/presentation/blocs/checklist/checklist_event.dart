part of 'checklist_bloc.dart';

sealed class ChecklistEvent extends Equatable {
  const ChecklistEvent();

  @override
  List<Object> get props => [];
}

final class EmptyInputs extends ChecklistEvent {}

final class LoadChecklists extends ChecklistEvent {
  final DrawerSectionView drawerSectionView;

  const LoadChecklists({
    this.drawerSectionView = DrawerSectionView.homepagechecklist,
  });

  @override
  List<Object> get props => [drawerSectionView];
}

final class RefreshChecklists extends ChecklistEvent {
  final DrawerSectionView drawerSectionView;

  const RefreshChecklists(
    this.drawerSectionView,
  );

  @override
  List<Object> get props => [drawerSectionView];
}

final class AddChecklist extends ChecklistEvent {
  final ChecklistModel checklist;

  const AddChecklist(
    this.checklist,
  );
  @override
  List<Object> get props => [checklist];
}

final class GetChecklistModelById extends ChecklistEvent {
  final String checklistId;

  const GetChecklistModelById(
    this.checklistId,
  );

  @override
  List<Object> get props => [checklistId];
}

final class UpdateChecklist extends ChecklistEvent {
  final ChecklistModel checklist;

  const UpdateChecklist(
    this.checklist,
  );

  @override
  List<Object> get props => [checklist];
}

final class DeleteChecklist extends ChecklistEvent {
  final String checklistId;

  const DeleteChecklist(
    this.checklistId,
  );
  @override
  List<Object> get props => [checklistId];
}

final class ModifColorChecklist extends ChecklistEvent {
  final int colorIndex;

  const ModifColorChecklist(
    this.colorIndex,
  );
  @override
  List<Object> get props => [colorIndex];
}

final class MoveChecklist extends ChecklistEvent {
  final ChecklistModel? checklist;
  final StateChecklist newStatus;

  const MoveChecklist(
    this.checklist,
    this.newStatus,
  );

  @override
  List<Object> get props => [];
}

final class UndoMoveChecklist extends ChecklistEvent {}

final class PopChecklistAction extends ChecklistEvent {
  final ChecklistModel currentChecklist;
  final ChecklistModel originChecklist;

  const PopChecklistAction(
    this.currentChecklist,
    this.originChecklist,
  );
  @override
  List<Object> get props => [currentChecklist, originChecklist];
}














// class AvailableChecklist extends ChecklistEvent {
//   final Checklist Checklist;

//   const AvailableChecklist(
//     this.Checklist,
//   );

//   @override
//   List<Object> get props => [Checklist];
// }

// class ReadOnlyChecklist extends ChecklistEvent {
//   final Checklist Checklist;

//   const ReadOnlyChecklist(
//     this.Checklist,
//   );

//   @override
//   List<Object> get props => [Checklist];
// }
