import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterkeepme/core/widgets/item_dismissible_checklist.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';


import '../../../blocs/blocs.dart';
import '../../../../../../core/core.dart';

class GridNotesChecklist extends StatelessWidget {
  final List<ChecklistModel> checklist;
  final bool isShowDismisse;

  const GridNotesChecklist({
    Key? key,
    required this.checklist,
    this.isShowDismisse = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusGridCubit, StatusGridState>(
      builder: (context, state) {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          sliver: _buildMasonryGrid(
            currentStatusCrossCount(
              (state as StatusGridViewState).currentStatus,
            ),
          ),
        );
      },
    );
  }

  int currentStatusCrossCount(GridStatus currentStatus) =>
      currentStatus == GridStatus.multiView ? 2 : 1;

  SliverMasonryGrid _buildMasonryGrid(int crossAxisCount) {
    return SliverMasonryGrid.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      childCount: checklist.length,
      itemBuilder: (_, index) {
        final ChecklistModel itemChecklist = checklist[index];
        return ItemDismissibleChecklist(
          itemChecklist: itemChecklist,
          isShowDismisse: isShowDismisse,
        );
      },
    );
  }
}
