import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/util/constants/icons/app_icons.dart';
import 'package:flutterkeepme/features/presentation/blocs/status_icons_checklist/status_icons_cubit_checklist.dart';



class MoreIconNote extends StatelessWidget {
  const MoreIconNote({
    super.key,
    required this.pressMore,
    required this.pressRecovery,
  });

  final VoidCallback pressMore;
  final VoidCallback pressRecovery;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusIconsCubitChecklist, StatusIconsStateChecklist>(
      buildWhen: (previous, current) => current is ReadOnlyStateChecklist,
      builder: (context, state) {
        final currentState =
            context.read<StatusIconsCubitChecklist>().state is ReadOnlyStateChecklist;
        return IconButton(
          padding: EdgeInsets.zero,
          icon: AppIcons.more,
          onPressed: currentState ? pressRecovery : pressMore,
        );
      },
    );
  }
}
