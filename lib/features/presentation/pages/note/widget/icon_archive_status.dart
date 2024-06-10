import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/data/model/note_model.dart';
import '/core/core.dart';

import '../../../blocs/blocs.dart';

class IconArchiveStatus extends StatelessWidget {
  const IconArchiveStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusIconsCubit, StatusIconsState>(
      buildWhen: (previous, current) => current is ToggleIconsStatusState,
      builder: (context, state) {
        final currentNote = (state as ToggleIconsStatusState).currentNote;
        final currentNoteStatus = (state).currentNoteStatus;
        final currentArchiveStatus = (state).currentArchiveStatus;

        return IconButton(
          icon: _iconCurrentStatus(currentArchiveStatus),
          onPressed: () => _onToggleArchiveStatus(
            context: context,
            currentNote: currentNote,
            currentNoteStatus: currentNoteStatus,
          ),
        );
      },
    );
  }

  Icon _iconCurrentStatus(ArchiveStatus currentStatus) {
    return currentStatus == ArchiveStatus.archive
        ? AppIcons.archiveNote
        : AppIcons.unarchiveNote;
  }

  void _onToggleArchiveStatus({
    required BuildContext context,
    required NoteModel currentNote,
    required StateNote currentNoteStatus,
  }) {
    final newNoteStatus = currentNoteStatus == StateNote.archived
        ? StateNote.undefined
        : StateNote.archived;

    context.read<NoteBloc>().add(MoveNote(currentNote, newNoteStatus));
  }
}
