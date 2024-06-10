import 'package:flutter/widgets.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/presentation/pages/home_checklist/widgets/widgets_checklist.dart';

import '../core.dart';

class CommonChecklistsView extends StatelessWidget {
  const CommonChecklistsView({
    Key? key,
    required this.drawerSection,
    required this.otherChecklists,
    required this.pinnedChecklists,
  }) : super(key: key);

  final DrawerSectionView drawerSection;
  final List<ChecklistModel> otherChecklists;
  final List<ChecklistModel> pinnedChecklists;

  @override
  Widget build(BuildContext context) {
    print("oldu mu");
    return CustomScrollView(
      slivers: _switchChecklistsSectionView(drawerSection, otherChecklists, pinnedChecklists),
    );
  }

  List<Widget> _switchChecklistsSectionView(
    DrawerSectionView drawerViewChecklist,
    List<ChecklistModel> otherChecklists,
    List<ChecklistModel> pinnedChecklists,
  ) {
    switch (drawerViewChecklist) {
      case DrawerSectionView.home:
        return [
          pinnedChecklists.isNotEmpty
              ? const HeaderText(text: 'Pinned')
              : const SliverToBoxAdapter(),
          GridNotesChecklist(checklist: pinnedChecklists, isShowDismisse: true),
          const HeaderText(text: 'Other'),
          GridNotesChecklist(checklist: otherChecklists, isShowDismisse: true),
          const SliverToBoxAdapter(child: SizedBox(height: 120))
        ];
      case DrawerSectionView.archive:
        return [GridNotesChecklist(checklist: otherChecklists, isShowDismisse: false)];
      case DrawerSectionView.trash:
        return [GridNotesChecklist(checklist: otherChecklists, isShowDismisse: false)];
    }
  }
}
