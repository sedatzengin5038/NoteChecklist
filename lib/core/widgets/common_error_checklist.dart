// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutterkeepme/core/util/function/app_function_checklist.dart';

import '/core/core.dart';

class CommonErrorChecklist extends StatelessWidget {
  final DrawerSectionView drawerViewChecklist;

  const CommonErrorChecklist({
    Key? key,
    required this.drawerViewChecklist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _switchErrorSection(context, drawerViewChecklist);
  }

  _switchErrorSection(BuildContext context, DrawerSectionView drawerViewChecklist) {
    switch (drawerViewChecklist) {
      case DrawerSectionView.home:
        return CommonFixScrolling(
          onRefresh: () => AppFunctionChecklist.onRefreshChecklist(context),
          child: _errorSection(AppIcons.error, 'errorMsg'),
        );
      case DrawerSectionView.archive:
        return _errorSection(AppIcons.error, 'errorMsg');
      case DrawerSectionView.trash:
        return _errorSection(AppIcons.error, 'errorMsg');
    }
  }

  _errorSection(Icon appIcons, String errorMsg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [appIcons, const SizedBox(height: 5.0), Text(errorMsg)],
      ),
    );
  }
}
