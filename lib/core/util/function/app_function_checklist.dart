import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/config/enum/drawer_section_view_checklist.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';


abstract class AppFunctionChecklist {
  static Future onRefreshChecklist(BuildContext context) async {
    BlocProvider.of<ChecklistBloc>(context).add(
      const LoadChecklists(drawerSectionViewChecklist: DrawerSectionViewChecklist.homepagechecklist),
    );
  }
}
