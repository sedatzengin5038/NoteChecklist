import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/../core/config/enum/status_Checklist.dart';




import '../../../blocs/status_icons_checklist/status_icons_cubit_checklist.dart';

import '/../../../../core/core.dart';


class IconPinnedStatusChecklist extends StatelessWidget {
  const IconPinnedStatusChecklist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusIconsCubitChecklist, StatusIconsStateChecklist>(
      buildWhen: (previous, current) => current is ToggleIconsStatusStateChecklist,
      builder: (context, state) {
  if (state is ToggleIconsStatusStateChecklist) {
    final currentStatus = state.currentChecklistStatus;
    return IconButton(
      icon: Icon(iconCurrentStatus(currentStatus)),
      onPressed: () => _onTogglePinnedStatus(context, currentStatus),
    );
  } else {
    // Handle other state types if needed
    return Container(); // Placeholder, replace with appropriate UI
  }
},
    );
  }

  IconData iconCurrentStatus(StateChecklist currentStatus) {
    return currentStatus == StateChecklist.pinned ? AppIcons.pin : AppIcons.unPin;
  }

  void _onTogglePinnedStatus(BuildContext context, StateChecklist currentStatus) {
    return context
        .read<StatusIconsCubitChecklist>()
        .toggleIconPinnedStatus(currentStatus);
  }
}
