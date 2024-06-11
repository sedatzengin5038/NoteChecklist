import 'package:flutter/material.dart';
import 'package:flutterkeepme/core/config/enum/drawer_section_view_checklist.dart';
import 'package:flutterkeepme/core/util/function/app_function_checklist.dart';
import '/core/core.dart';

class CommonEmptyChecklists extends StatelessWidget {
  const CommonEmptyChecklists(this.drawerView) : super(key: null);

  final DrawerSectionView drawerView;

  @override
  Widget build(BuildContext context) {
    return _switchEmptySectionChecklist(context, drawerView);
  }

  _switchEmptySectionChecklist(BuildContext context, DrawerSectionView drawerViewChecklist) {
    switch (drawerViewChecklist) {
      case DrawerSectionView.homepagechecklist:
        return CommonFixScrolling(
          onRefresh: () => AppFunctionChecklist.onRefreshChecklist(context),
          child: _emptySectionChecklist(
            AppIcons.emptyNote,
            'Checklist you add appear here',
          ),
        );
      case DrawerSectionView.home:
        return CommonFixScrolling(
          onRefresh: () => AppFunctionChecklist.onRefreshChecklist(context),
          child: _emptySectionChecklist(
            AppIcons.emptyNote,
            'Checklist you add appear here',
          ),
        );  
      case DrawerSectionView.homepagechecklist:
        return CommonFixScrolling(
          onRefresh: () => AppFunctionChecklist.onRefreshChecklist(context),
          child: _emptySectionChecklist(
            AppIcons.emptyNote,
            'Checklist you add appear here',
          ),
        );  
      case DrawerSectionView.archive:
        return _emptySectionChecklist(
          AppIcons.emptyArchivesNote,
          'Your archived Checklists appear here',
        );
      case DrawerSectionView.trash:
        return _emptySectionChecklist(
          AppIcons.emptyTrashNote,
          'No Checklists in Recycle Bin',
        );
    }
  }

  _emptySectionChecklist(Icon appIcons, String errorMsg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [appIcons, const SizedBox(height: 5.0), Text(errorMsg)],
      ),
    );
  }
}
