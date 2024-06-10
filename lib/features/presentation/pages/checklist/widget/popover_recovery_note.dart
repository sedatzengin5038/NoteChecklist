import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/config/enum/status_Checklist.dart';
import 'package:flutterkeepme/core/util/alerts_checklist/app_alerts_checklist.dart';
import 'package:flutterkeepme/core/util/constants/icons/app_icons.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';
import 'package:go_router/go_router.dart';



class PopoverRecoveryChecklist extends StatelessWidget {
  const PopoverRecoveryChecklist({super.key, required this.checklist});

  final ChecklistModel checklist;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: AppIcons.restoreNote,
            title: const Text('Restore'),
            onTap: () => _onRestoreNote(context),
          ),
          ListTile(
            leading: AppIcons.deleteNote,
            title: const Text('Delete foverver'),
            onTap: () => AppAlertsChecklist.showAlertDeleteDialog(context, checklist),
          ),
        ],
      ),
    );
  }

  void _onRestoreNote(BuildContext context) {
    context.read<ChecklistBloc>().add(MoveChecklist(checklist, StateChecklist.undefined));
    context.pop();
  }
}
