import 'package:flutter/widgets.dart';
import '/features/data/model/note_model.dart';

import '../../features/presentation/pages/home/widgets/widgets.dart';
import '../core.dart';

class CommonNotesView extends StatelessWidget {
  const CommonNotesView({
    Key? key,
    required this.drawerSection,
    required this.otherNotes,
    required this.pinnedNotes,
  }) : super(key: key);

  final DrawerSectionView drawerSection;
  final List<NoteModel> otherNotes;
  final List<NoteModel> pinnedNotes;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _switchNotesSectionView(drawerSection, otherNotes, pinnedNotes),
    );
  }

  List<Widget> _switchNotesSectionView(
    DrawerSectionView drawerViewNote,
    List<NoteModel> otherNotes,
    List<NoteModel> pinnedNotes,
  ) {
    switch (drawerViewNote) {
      case DrawerSectionView.home:
        return [
          pinnedNotes.isNotEmpty
              ? const HeaderText(text: 'Pinned')
              : const SliverToBoxAdapter(),
          GridNotes(notes: pinnedNotes, isShowDismisse: true),
          const HeaderText(text: 'Other'),
          GridNotes(notes: otherNotes, isShowDismisse: true),
          const SliverToBoxAdapter(child: SizedBox(height: 120))
        ];
      case DrawerSectionView.archive:
        return [GridNotes(notes: otherNotes, isShowDismisse: false)];
      case DrawerSectionView.trash:
        return [GridNotes(notes: otherNotes, isShowDismisse: false)];
    }
  }
}
