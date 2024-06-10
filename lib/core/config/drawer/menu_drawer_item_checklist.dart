import 'package:flutter/material.dart';
import 'package:flutterkeepme/core/util/function/drawer_select_checklist.dart';

import '/core/config/enum/drawer_views.dart';
import '/core/util/util.dart';

class MenuDrawerItemChecklist extends StatelessWidget {
  const MenuDrawerItemChecklist(this.drawerViews) : super(key: null);

  final DrawerViews drawerViews;

  @override
  Widget build(BuildContext context) {
    final isDrawerSelected = DrawerSelectChecklist.drawerViews == drawerViews;
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        title: Text(drawerViews.name),
        leading: drawerViews.icon,
        onTap: () => _onTapDrawerChecklist(context, isDrawerSelected),
        selected: isDrawerSelected,
        selectedColor: context.colorScheme.onPrimaryContainer,
        selectedTileColor: context.colorScheme.primary.withOpacity(0.2),
      ),
    );
  }

  void _onTapDrawerChecklist(BuildContext context, bool drawerSelected) {
    if (!drawerSelected) {
      drawerViews.onTapItemDrawerChecklist(context);
    } else {
      Navigator.pop(context);
    }
  }
}
