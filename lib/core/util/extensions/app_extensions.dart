import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/config/enum/status_Checklist.dart';
import 'package:flutterkeepme/core/util/function/drawer_select_checklist.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';
import 'package:go_router/go_router.dart';


import '../../../features/presentation/blocs/blocs.dart';
import '../../config/enum/enum.dart';
import '../util.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get _theme => Theme.of(this);
  TextTheme get textTheme => _theme.textTheme;
  ColorScheme get colorScheme => _theme.colorScheme;
  Size get deviceSize => MediaQuery.sizeOf(this);
}

extension StateGridViewIcon on GridStatus {
  IconData get icon {
    switch (this) {
      case GridStatus.singleView:
        return AppIcons.grip;
      case GridStatus.multiView:
        return AppIcons.gripVertical;
    }
  }
}

extension DrawerViewsExtensions on DrawerViews {
  String get name {
    switch (this) {
      case DrawerViews.home:
        return 'Notes';
      case DrawerViews.homechecklist:
        return 'checklist';        
      case DrawerViews.archive:
        return 'Archive';
      case DrawerViews.trash:
        return 'Trash';
      case DrawerViews.setting:
        return 'Setting';
      case DrawerViews.checklist:
        return 'checklist';  
    }
  }

  Icon get icon {
    switch (this) {
      case DrawerViews.home:
        return AppIcons.pen;
      case DrawerViews.homechecklist:
        return AppIcons.pen_check_home; 
      case DrawerViews.archive:
        return AppIcons.archive;
      case DrawerViews.trash:
        return AppIcons.trash;
      case DrawerViews.setting:
        return AppIcons.setting;
      case DrawerViews.checklist:
        return AppIcons.check;  
    }
  }

  void Function(BuildContext context) get onTapItemDrawer {
    return (context) {
      if (this != DrawerViews.setting) DrawerSelect.selectedDrawerView = this;

      DrawerSelect.selectedDrawerSection = drawerSectionForView(this);

      if (this == DrawerViews.homechecklist) {
        context.read<ChecklistBloc>().add(RefreshChecklists(DrawerSelectChecklist.drawerSectionChecklist));

      final String? routerName = routerNameForView(this);
      if (routerName != null) {
        if (routerName == AppRouterName.setting.name) {
          GoRouter.of(context).pushNamed(routerName);
        } else {
          GoRouter.of(context).goNamed(routerName);
        }
      }
      Navigator.pop(context);
      }
      else {
        context.read<NoteBloc>().add(RefreshNotes(DrawerSelect.drawerSection));

      final String? routerName = routerNameForView(this);
      if (routerName != null) {
        if (routerName == AppRouterName.setting.name) {
          GoRouter.of(context).pushNamed(routerName);
        } else {
          GoRouter.of(context).goNamed(routerName);
        }
      }
      Navigator.pop(context);
      }
      
    };
  }
  void Function(BuildContext context) get onTapItemDrawerChecklist {
    return (context) {
      if (this != DrawerViews.setting) DrawerSelect.selectedDrawerView = this;

      DrawerSelect.selectedDrawerSection = drawerSectionForView(this);
      context.read<ChecklistBloc>().add(RefreshChecklists(DrawerSelectChecklist.drawerSectionChecklist));

      final String? routerName = routerNameForView(this);
      if (routerName != null) {
        if (routerName == AppRouterName.setting.name) {
          GoRouter.of(context).pushNamed(routerName);
        } else {
          GoRouter.of(context).goNamed(routerName);
        }
      }
      Navigator.pop(context);
    };
  }  

  String? routerNameForView(DrawerViews view) {
    switch (view) {
      case DrawerViews.home:
        return AppRouterName.home.name;
      case DrawerViews.homechecklist:
        return AppRouterName.homechecklist.name;
      case DrawerViews.archive:
        return AppRouterName.archive.name;
      case DrawerViews.trash:
        return AppRouterName.trash.name;
      case DrawerViews.setting:
        return AppRouterName.setting.name;
      case DrawerViews.checklist:
        return AppRouterName.checklist.name;  
      default:
        return null;
    }
  }

  DrawerSectionView drawerSectionForView(DrawerViews view) {
    switch (view) {
      case DrawerViews.home:
        return DrawerSectionView.home;
      case DrawerViews.archive:
        return DrawerSectionView.archive;
      case DrawerViews.trash:
        return DrawerSectionView.trash;
      default:
        return DrawerSelect.drawerSection;
    }
  }

  
}

extension StatusNoteX on StateNote {
  StateNote get stateNote {
    if (this == StateNote.undefined) {
      return StateNote.unspecified;
    } else if (this == StateNote.pinned) {
      return StateNote.pinned;
    } else if (this == StateNote.archived) {
      return StateNote.archived;
    } else if (this == StateNote.trash) {
      return StateNote.trash;
    } else {
      return StateNote.unspecified; // Varsayılan durumu döndür
    }
  }
}



extension StatusFirebaseNoteX on StateNote {
  StateNote get stateNote {
    switch (this) {
      case StateNote.unspecified:
        return StateNote.undefined;
      case StateNote.pinned:
        return StateNote.pinned;
      case StateNote.archived:
        return StateNote.archived;
      case StateNote.trash:
        return StateNote.trash;

      default:
        return StateNote.undefined; // Varsayılan durumu döndür
    }
  }


  
}

extension StatusChecklistX on StateChecklist {
  StateChecklist get stateChecklist {
    if (this == StateNote.undefined) {
      return StateChecklist.unspecified;
    } else if (this == StateChecklist.pinned) {
      return StateChecklist.pinned;
    } else if (this == StateChecklist.archived) {
      return StateChecklist.archived;
    } else if (this == StateChecklist.trash) {
      return StateChecklist.trash;
    } else {
      return StateChecklist.unspecified; // Varsayılan durumu döndür
    }
  }
}



extension StatusFirebaseChecklistX on StateChecklist {
  StateChecklist get stateChecklist {
    switch (this) {
      case StateChecklist.unspecified:
        return StateChecklist.undefined;
      case StateChecklist.pinned:
        return StateChecklist.pinned;
      case StateChecklist.archived:
        return StateChecklist.archived;
      case StateChecklist.trash:
        return StateChecklist.trash;

      default:
        return StateChecklist.undefined; // Varsayılan durumu döndür
    }
  }

}