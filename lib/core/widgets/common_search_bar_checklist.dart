import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/widgets/icon_grid_status_checklist.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';
import '../core.dart';

class CommonSearchBarChecklist extends StatelessWidget {
  const CommonSearchBarChecklist({super.key});

  final String hintText = 'Search your checklist';

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () => _openDrawerChecklist(context),
                    ),
                    Text(hintText, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                const Row(
                  children: [IconStatusGridChecklist(), IconProfile()],
                ),
              ],
            ),
            onTap: () => _showSearchChecklist(context),
          ),
        ),
      ),
    );
  }

  void _openDrawerChecklist(BuildContext context) {
    context.read<ChecklistBloc>().appScaffoldState.currentState!.openDrawer();
  }

  Future _showSearchChecklist(BuildContext context) =>
      showSearch(context: context, delegate: ChecklistsSearching());
}