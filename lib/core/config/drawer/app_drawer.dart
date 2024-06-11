import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/presentation/blocs/blocs.dart';
import '../../core.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentLocation = GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();

    // Check the current route location
    if (currentLocation == '/homechecklist') {
      // Return BlocBuilder for ChecklistBloc if the current location is '/homechecklist'
      return BlocBuilder<ChecklistBloc, ChecklistState>(
        builder: (context, checklistState) {
          return _buildDrawerContent(context);
        },
      );
    } else {
      // Return BlocBuilder for NoteBloc for other routes
      return BlocBuilder<NoteBloc, NoteState>(
        builder: (context, noteState) {
          return _buildDrawerContent(context);
        },
      );
    }
  }

  Widget _buildDrawerContent(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildTextLOGO(context),
            const MenuDrawerItem(DrawerViews.home),
            const MenuDrawerItem(DrawerViews.homechecklist),
            const Divider(),
            const MenuDrawerItem(DrawerViews.archive),
            const MenuDrawerItem(DrawerViews.trash),
            const MenuDrawerItem(DrawerViews.setting),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    );
  }

  Widget _buildTextLOGO(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Text.rich(
        style: Theme.of(context).textTheme.headlineSmall,
        TextSpan(
          children: [
            TextSpan(
              text: 'KeepUp Note',
              style: const TextStyle().copyWith(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: ' '),
            const TextSpan(text: 'Note'),
          ],
        ),
      ),
    );
  }
}
