import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/core.dart';

import '../../features/presentation/blocs/blocs.dart';

class IconStatusGridChecklist extends StatelessWidget {
  const IconStatusGridChecklist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusGridCubit, StatusGridState>(
      buildWhen: (previous, current) => current is StatusGridViewState,
      builder: (context, state) {
        final currentStatus = (state as StatusGridViewState).currentStatus;
        return IconButton(
          icon: Icon(_iconCurrentStatus(currentStatus)),
          onPressed: () {
            context.read<StatusGridCubit>().toggleStatusGrid(currentStatus);
          },
        );
      },
    );
  }

  IconData _iconCurrentStatus(GridStatus currentStatus) =>
      currentStatus == GridStatus.singleView
          ? GridStatus.singleView.icon
          : GridStatus.multiView.icon;
}
