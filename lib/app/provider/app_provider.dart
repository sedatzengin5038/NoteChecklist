import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/config/enum/drawer_section_view_checklist.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';
import 'package:flutterkeepme/features/presentation/blocs/search_checklist/search_cubit_checklist.dart';
import "../../core/core.dart";
import "../../app/di/get_it.dart" as di;
import '../../features/presentation/blocs/blocs.dart';

class AppProviders extends StatelessWidget {
  final Widget child;
  const AppProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.gI<NoteBloc>()
            ..add(const LoadNotes(drawerSectionView: DrawerSectionView.home)),
        ),
        BlocProvider(
          create: (_) => di.gI<ChecklistBloc>()
            ..add(const LoadChecklists(drawerSectionViewChecklist: DrawerSectionViewChecklist.homepagechecklist)),
        ),
        BlocProvider(create: (_) => di.gI<StatusGridCubit>()),
        BlocProvider(create: (_) => di.gI<StatusIconsCubit>()),
        BlocProvider(create: (_) => di.gI<StatusIconsCubitChecklist>()),
        BlocProvider(create: (_) => di.gI<ProfileCubit>()),
        BlocProvider(create: (_) => di.gI<SearchCubit>()),
        BlocProvider(create: (_) => di.gI<SearchCubitChecklist>()),
        BlocProvider(create: (_) => di.gI<ThemeCubit>()..getCurrentThemeMode()),
        BlocProvider(create: (_) => di.gI<ChecklistBloc>()), // Add ChecklistBloc here
      ],
      child: child,
    );
  }
}

