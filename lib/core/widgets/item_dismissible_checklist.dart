import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/config/enum/status_Checklist.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';
import 'package:flutterkeepme/features/presentation/pages/checklist/widget/item_checklist.dart';


class ItemDismissibleChecklist extends StatelessWidget {
  const ItemDismissibleChecklist({
    Key? key,
    required this.itemChecklist,
    required this.isShowDismisse,
  }) : super(key: key);

  final ChecklistModel itemChecklist;
  final bool isShowDismisse;

  @override
  Widget build(BuildContext context) {
    return isShowDismisse
        ? Dismissible(
            //background: Container(color: Colors.amber),
            key: ValueKey<String>(itemChecklist.id),
            child: ItemChecklist(checklist: itemChecklist),
            onDismissed: (direction) => _onDismissed(context, itemChecklist),
          )
        : ItemChecklist(checklist: itemChecklist);
  }

  void _onDismissed(BuildContext context, ChecklistModel itemNote) {
    context.read<ChecklistBloc>().add(MoveChecklist(itemChecklist, StateChecklist.archived));
  }
}
