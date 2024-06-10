import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/config/enum/status_Checklist.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';

import '/core/core.dart';

import '../../../blocs/blocs.dart';

class IconArchiveStatusChecklist extends StatelessWidget {
  const IconArchiveStatusChecklist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusIconsCubitChecklist, StatusIconsStateChecklist>(
  buildWhen: (previous, current) => current is ToggleIconsStatusStateChecklist,
  builder: (context, state) {
    if (state is ToggleIconsStatusStateChecklist) {
      final currentChecklist = state.currentChecklist;
      final currentChecklistStatus = state.currentChecklistStatus;
      final currentArchiveStatus = state.currentArchiveStatus;
      return IconButton(
        icon: _iconCurrentStatus(currentArchiveStatus),
        onPressed: () => _onToggleArchiveStatus(
          context: context,
          currentChecklist: currentChecklist,
          currentChecklistStatus: currentChecklistStatus,
        ),
      );
    } else {
      // Handle other states
      return Container(); // Placeholder, replace with appropriate UI
    }
  },
);

  }

  Icon _iconCurrentStatus(ArchiveStatus currentStatus) {
    return currentStatus == ArchiveStatus.archive
        ? AppIcons.checklist
        : AppIcons.check;
  }

  void _onToggleArchiveStatus({
    required BuildContext context,
    required ChecklistModel currentChecklist,
    required StateChecklist currentChecklistStatus,
  }) {
    final newChecklistStatus = currentChecklistStatus == StateChecklist.archived
        ? StateChecklist.undefined
        : StateChecklist.archived;

    context.read<ChecklistBloc>().add(MoveChecklist(currentChecklist, newChecklistStatus));
  }
}
