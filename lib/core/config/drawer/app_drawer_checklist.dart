import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/config/drawer/drawer_checklist.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';
import '../../core.dart';

class AppDrawerChecklist extends StatelessWidget {
  const AppDrawerChecklist({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChecklistBloc, ChecklistState>(
      builder: (context, state) {
        return Drawer(
          //width: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderChecklist(context),
                _buildTextLOGOChecklist(context),
                const MenuDrawerItemChecklist(DrawerViews.home),
                const MenuDrawerItemChecklist(DrawerViews.homechecklist),
                const Divider(),
                const MenuDrawerItemChecklist(DrawerViews.archive),
                const MenuDrawerItemChecklist(DrawerViews.trash),
                const MenuDrawerItemChecklist(DrawerViews.setting),
                const Divider(),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildHeaderChecklist(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    );
  }

  _buildTextLOGOChecklist(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Text.rich(
        style: context.textTheme.headlineSmall,
        TextSpan(
          children: [
            TextSpan(
              text: 'KeepUp Note',
              style: const TextStyle().copyWith(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: ' '),
            const TextSpan(text: 'Checklist'),
          ],
        ),
      ),
    );
  }
//
}
