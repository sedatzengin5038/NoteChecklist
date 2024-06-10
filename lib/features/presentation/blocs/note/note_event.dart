part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

final class EmptyInputs extends NoteEvent {}

final class LoadNotes extends NoteEvent {
  final DrawerSectionView drawerSectionView;

  const LoadNotes({
    this.drawerSectionView = DrawerSectionView.home,
  });

  @override
  List<Object> get props => [drawerSectionView];
}

final class RefreshNotes extends NoteEvent {
  final DrawerSectionView drawerSectionView;

  const RefreshNotes(
    this.drawerSectionView,
  );

  @override
  List<Object> get props => [drawerSectionView];
}

final class AddNote extends NoteEvent {
  final NoteModel note;

  const AddNote(
    this.note,
  );
  @override
  List<Object> get props => [note];
}

final class GetNoteModelById extends NoteEvent {
  final String noteId;

  const GetNoteModelById(
    this.noteId,
  );

  @override
  List<Object> get props => [noteId];
}

final class UpdateNote extends NoteEvent {
  final NoteModel note;

  const UpdateNote(
    this.note,
  );

  @override
  List<Object> get props => [note];
}

final class DeleteNote extends NoteEvent {
  final String noteId;

  const DeleteNote(
    this.noteId,
  );
  @override
  List<Object> get props => [noteId];
}

final class ModifColorNote extends NoteEvent {
  final int colorIndex;

  const ModifColorNote(
    this.colorIndex,
  );
  @override
  List<Object> get props => [colorIndex];
}

final class MoveNote extends NoteEvent {
  final NoteModel? note;
  final StateNote newStatus;

  const MoveNote(
    this.note,
    this.newStatus,
  );

  @override
  List<Object> get props => [];
}

final class UndoMoveNote extends NoteEvent {}

final class PopNoteAction extends NoteEvent {
  final NoteModel currentNote;
  final NoteModel originNote;

  const PopNoteAction(
    this.currentNote,
    this.originNote,
  );
  @override
  List<Object> get props => [currentNote, originNote];
}














// class AvailableNote extends NoteEvent {
//   final Note note;

//   const AvailableNote(
//     this.note,
//   );

//   @override
//   List<Object> get props => [note];
// }

// class ReadOnlyNote extends NoteEvent {
//   final Note note;

//   const ReadOnlyNote(
//     this.note,
//   );

//   @override
//   List<Object> get props => [note];
// }
