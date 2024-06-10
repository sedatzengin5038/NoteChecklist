
part of 'checklist_bloc.dart';

sealed class ChecklistState extends Equatable {
  const ChecklistState();

  @override
  List<Object> get props => [];
}

final class LoadingStateChecklist extends ChecklistState {
  final DrawerSectionViewChecklist drawerSectionViewChecklist;

  const LoadingStateChecklist(
    this.drawerSectionViewChecklist,
  );

  @override
  List<Object> get props => [drawerSectionViewChecklist];
}

final class ChecklistsViewState extends ChecklistState {
  final List<ChecklistModel> otherChecklists;
  final List<ChecklistModel> pinnedChecklists;

  const ChecklistsViewState(
    this.otherChecklists,
    this.pinnedChecklists,
  );
  @override
  List<Object> get props => [pinnedChecklists, otherChecklists];
}

final class ModifedColorChecklistState extends ChecklistState {
  final int colorIndex;

  const ModifedColorChecklistState(
    this.colorIndex,
  );
  @override
  List<Object> get props => [colorIndex];
}

final class GetChecklistByIdState extends ChecklistState {
  final ChecklistModel checklist;

  const GetChecklistByIdState(this.checklist);

  @override
  List<Object> get props => [checklist];
}

//===>  MessageState

final class MessageState extends ChecklistState {
  final String message;

  const MessageState(this.message);
  @override
  List<Object> get props => [message];
}

final class ErrorState extends MessageState {
  final DrawerSectionViewChecklist drawerSectionViewChecklist;
  const ErrorState(
    super.message,
    this.drawerSectionViewChecklist,
  );
  @override
  List<Object> get props => [message, drawerSectionViewChecklist];
}

final class SuccessState extends MessageState {
  const SuccessState(super.message);
}

final class ToggleSuccessState extends MessageState {
  const ToggleSuccessState(super.message);
}

final class EmptyInputsState extends MessageState {
  const EmptyInputsState(super.message);
}

//===>  MessageState
final class GoPopChecklistState extends ChecklistState {}

final class EmptyChecklistState extends ChecklistState {
  final DrawerSectionViewChecklist drawerSectionViewChecklist;

  const EmptyChecklistState(
    this.drawerSectionViewChecklist,
  );

  @override
  List<Object> get props => [drawerSectionViewChecklist];
}

final class AvailableChecklistState extends ChecklistState {
  final ChecklistModel checklist;

  const AvailableChecklistState(
    this.checklist,
  );

  @override
  List<Object> get props => [checklist];
}

final class ReadOnlyChecklistState extends ChecklistState {
  final bool readOnly;

  const ReadOnlyChecklistState(
    this.readOnly,
  );

  @override
  List<Object> get props => [readOnly];
}
