// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutterkeepme/core/config/enum/drawer_section_view_checklist.dart';
import 'package:flutterkeepme/core/util/function/app_function_checklist.dart';


import '../core.dart';

class CommonLoadingChecklist extends StatelessWidget {
  const CommonLoadingChecklist(
    this.checklistSection,
  ) : super(key: null);

  final DrawerSectionViewChecklist checklistSection;
  

  @override
  Widget build(BuildContext context) {
    return switchLoadingViewChecklistsSection(context, checklistSection);
  }

  Widget switchLoadingViewChecklistsSection(
    BuildContext context,
    DrawerSectionViewChecklist drawerViewChecklist,
  ) {
    switch (drawerViewChecklist) {
      
      case DrawerSectionViewChecklist.homepagechecklist:
        
        return CommonFixScrolling(
          onRefresh: () => AppFunctionChecklist.onRefreshChecklist(context),
          child: const CircularProgressIndicator(),
        );
      case DrawerSectionViewChecklist.home:
        
        return CommonFixScrolling(
          onRefresh: () => AppFunctionChecklist.onRefreshChecklist(context),
          child: const CircularProgressIndicator(),
        );  
      
      case DrawerSectionViewChecklist.archive:
        return const Center(child: CircularProgressIndicator());
      case DrawerSectionViewChecklist.trash:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
