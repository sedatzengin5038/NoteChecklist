import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/config/enum/status_Checklist.dart';
import 'package:flutterkeepme/core/util/constants/icons/app_icons.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';
import 'package:go_router/go_router.dart';



class PopoverMoreChecklist extends StatelessWidget {
  final ChecklistModel checklist;
  const PopoverMoreChecklist({super.key, required this.checklist});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: AppIcons.trashNote,
            title: const Text('Trash'),
            onTap: () => _onTrashNote(context),
          ),
          ListTile(
            leading: AppIcons.sendNote,
            title: const Text('Send'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void _onTrashNote(BuildContext context) {
    context.read<ChecklistBloc>().add(MoveChecklist(checklist, StateChecklist.trash));
    context.pop();
  }
}
