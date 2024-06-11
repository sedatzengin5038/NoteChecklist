import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/config/searching/checklist_searching.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';
import '../../features/presentation/blocs/blocs.dart';
import '../core.dart';

import 'package:flutterkeepme/core/config/searching/notes_searching.dart';

import 'package:flutterkeepme/features/presentation/blocs/note/note_bloc.dart';

class CommonSearchBar extends StatelessWidget {
  const CommonSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String hintText = _determineHintText(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          borderRadius: BorderRadius.circular(25),
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: AppIcons.menu,
                      onPressed: () => _openDrawer(context),
                    ),
                    Text(hintText, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                const Row(
                  children: [IconStatusGridNote(), IconProfile()],
                ),
              ],
            ),
            onTap: () => _determineAndShowSearch(context),
          ),
        ),
      ),
    );
  }

  String _determineHintText(BuildContext context) {
    var noteBlocScaffoldState = context.read<NoteBloc>().appScaffoldState.currentState;
    if (noteBlocScaffoldState != null) {
      return 'Search your notes';
    } else {
      var checklistBlocScaffoldState = context.read<ChecklistBloc>().appScaffoldState.currentState;
      if (checklistBlocScaffoldState != null) {
        return 'Search your checklists';
      } else {
        print('Both NoteBloc and ChecklistBloc ScaffoldStates are null');
        return 'Search';
      }
    }
  }

  void _openDrawer(BuildContext context) {
    var scaffoldState = context.read<NoteBloc>().appScaffoldState.currentState;
    if (scaffoldState != null) {
      scaffoldState.openDrawer();
    } else {
      scaffoldState = context.read<ChecklistBloc>().appScaffoldState.currentState;
      if (scaffoldState != null) {
        scaffoldState.openDrawer();
      } else {
        print('Both NoteBloc and ChecklistBloc ScaffoldStates are null');
      }
    }
  }

  void _determineAndShowSearch(BuildContext context) {
    var noteBlocScaffoldState = context.read<NoteBloc>().appScaffoldState.currentState;
    if (noteBlocScaffoldState != null) {
      _showSearch(context);
    } else {
      var checklistBlocScaffoldState = context.read<ChecklistBloc>().appScaffoldState.currentState;
      if (checklistBlocScaffoldState != null) {
        _showSearchChecklist(context);
      } else {
        print('Both NoteBloc and ChecklistBloc ScaffoldStates are null');
      }
    }
  }

  Future _showSearch(BuildContext context) =>
      showSearch(context: context, delegate: NotesSearching());

  Future _showSearchChecklist(BuildContext context) =>
      showSearch(context: context, delegate: ChecklistsSearching());
}
