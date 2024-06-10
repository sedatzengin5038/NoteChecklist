import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/util/function/color_checklist.dart';
import 'package:flutterkeepme/core/widgets/item_checklist_card.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';




class ItemChecklist extends StatelessWidget {
  final ChecklistModel checklist;
  const ItemChecklist({
    super.key,
    required this.checklist,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorChecklist.getColor(context, checklist.colorIndex),
      margin: EdgeInsets.zero,
      elevation: .3,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        child: ItemChecklistCard(checklist: checklist),
        onTap: () => _onTapItem(context),
      ),
    );
  }

  _onTapItem(BuildContext context) {
    context.read<ChecklistBloc>().add(GetChecklistModelById(checklist.id));
  }
}
