import 'package:flutter/widgets.dart';
import 'package:flutterkeepme/core/config/enum/drawer_section_view_checklist.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/presentation/pages/home_checklist/widgets/widgets_checklist.dart';

import '../core.dart';

class CommonChecklistsViewChecklist extends StatelessWidget {
  const CommonChecklistsViewChecklist({
    Key? key,
    required this.drawerSection,
    required this.otherChecklists,
    required this.pinnedChecklists,
  }) : super(key: key);

  final DrawerSectionViewChecklist drawerSection;
  final List<ChecklistModel> otherChecklists;
  final List<ChecklistModel> pinnedChecklists;

  @override
  Widget build(BuildContext context) {
    print("oldu mu");
    return CustomScrollView(
      slivers: _switchChecklistsSectionViewChecklist(drawerSection, otherChecklists, pinnedChecklists),
    );
  }

  List<Widget> _switchChecklistsSectionViewChecklist(
    DrawerSectionViewChecklist drawerViewChecklist,
    List<ChecklistModel> otherChecklists,
    List<ChecklistModel> pinnedChecklists,
  ) {
    switch (drawerViewChecklist) {
      case DrawerSectionViewChecklist.homepagechecklist:
        return [
          pinnedChecklists.isNotEmpty
              ? const HeaderText(text: 'Pinned')
              : const SliverToBoxAdapter(),
          GridNotesChecklist(checklist: pinnedChecklists, isShowDismisse: true),
          const HeaderText(text: 'Other'),
          GridNotesChecklist(checklist: otherChecklists, isShowDismisse: true),
          const SliverToBoxAdapter(child: SizedBox(height: 120))
        ];

      case DrawerSectionViewChecklist.home:
        return [
          pinnedChecklists.isNotEmpty
              ? const HeaderText(text: 'Pinned')
              : const SliverToBoxAdapter(),
          GridNotesChecklist(checklist: pinnedChecklists, isShowDismisse: true),
          const HeaderText(text: 'Other'),
          GridNotesChecklist(checklist: otherChecklists, isShowDismisse: true),
          const SliverToBoxAdapter(child: SizedBox(height: 120))
        ];  
      case DrawerSectionViewChecklist.archive:
        return [GridNotesChecklist(checklist: otherChecklists, isShowDismisse: false)];
      case DrawerSectionViewChecklist.trash:
        return [GridNotesChecklist(checklist: otherChecklists, isShowDismisse: false)];
    }
  }
}
