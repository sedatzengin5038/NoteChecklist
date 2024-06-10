import 'package:flutterkeepme/core/config/enum/drawer_section_view_checklist.dart';

import '../../core.dart';

class DrawerSelectChecklist {
  static const DrawerViews defaultDrawerView = DrawerViews.homechecklist;
  static const DrawerSectionViewChecklist defaultDrawerSectionChecklist = DrawerSectionViewChecklist.homepagechecklist;
  //=>

  static DrawerViews _drawerViews = defaultDrawerView;
  static DrawerViews get drawerViews => _drawerViews;
  static set selectedDrawerView(DrawerViews newDrawerViews) =>
      _drawerViews = newDrawerViews;

  //==>
  static DrawerSectionViewChecklist _drawerSectionChecklist = defaultDrawerSectionChecklist;
  static DrawerSectionViewChecklist get drawerSectionChecklist => _drawerSectionChecklist;
  static set selectedDrawerSection(DrawerSectionViewChecklist newDrawerSectionViewChecklist) =>
      _drawerSectionChecklist = newDrawerSectionViewChecklist;
}
