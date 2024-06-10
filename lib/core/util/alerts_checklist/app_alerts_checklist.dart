import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/config/enum/status_Checklist.dart';

import 'package:flutterkeepme/core/util/function/color_checklist.dart';
import 'package:flutterkeepme/core/util/function/drawer_select_checklist.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/presentation/blocs/blocs.dart';
import '../../core.dart';

@immutable
class AppAlertsChecklist {
  const AppAlertsChecklist._();

  static void _displaySnackBar(
    BuildContext context,
    String message,
    String? actionLabel,
    void Function()? onPressed,
  ) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: context.textTheme.bodyMedium),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: context.colorScheme.primaryContainer,
          action: onPressed != null
              ? SnackBarAction(
                  textColor: context.colorScheme.onBackground,
                  label: actionLabel!,
                  onPressed: onPressed,
                )
              : null,
        ),
      );
  }

  static void displaySnackbarMsg(BuildContext context, String message) {
    _displaySnackBar(context, message, null, null);
  }

  static void displaySnackarUndoMove(BuildContext context, String message) {
    _displaySnackBar(
      context,
      message,
      'Undo',
      () => context.read<ChecklistBloc>().add(UndoMoveChecklist()),
    );
  }

  static void displaySnackarRecycle(BuildContext context, String message) {
    _displaySnackBar(
      context,
      message,
      'Recycle',
      () {
        final checklistStatusState = context.read<StatusIconsCubitChecklist>().state;

        if (checklistStatusState is ReadOnlyStateChecklist) {
          final currentChecklist = checklistStatusState.currentChecklist;
          context
              .read<ChecklistBloc>()
              .add(MoveChecklist(currentChecklist, StateChecklist.undefined));
        }
      },
    );
  }

  static Future<void> showAlertDeleteDialog(
    BuildContext context,
    ChecklistModel checklist,
  ) async {
    Widget cancelButton = TextButton(
      child: const Text('NO'),
      onPressed: () {
        context.pop();
        context.pop();
      },
    );
    Widget deleteButton = TextButton(
      child: const Text('YES'),
      onPressed: () {
        context.pop();
        context.pop();
        context.read<ChecklistBloc>().add(DeleteChecklist(checklist.id));
        context.read<ChecklistBloc>().add(RefreshChecklists(DrawerSelectChecklist.drawerSectionChecklist));
      },
    );
    AlertDialog alert = AlertDialog(
      backgroundColor: ColorChecklist.getColor(context, checklist.colorIndex),
      content: const Text('Are you sure you want to delete this Note?'),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
