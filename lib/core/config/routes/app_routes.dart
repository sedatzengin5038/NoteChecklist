import 'package:flutter/material.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/presentation/pages/checklist/checklist_page.dart';
import '/features/data/model/note_model.dart';
import 'package:go_router/go_router.dart';
import '../../../features/presentation/pages/views.dart';
import '../enum/enum.dart';


abstract class AppRouter {
  AppRouter._();

  static final _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRouterName.home.path,
    routes: [
      GoRoute(
        name: AppRouterName.home.name,
        path: AppRouterName.home.path,
        pageBuilder: (_, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const HomePage(),
          );
        },
        routes: [
          GoRoute(
            name: AppRouterName.note.name,
            path: AppRouterName.note.path,
            pageBuilder: (_, state) {
              return MaterialPage(
                key: state.pageKey,
                child: NotePage(
                  note: state.extra as NoteModel,
                ),
              );
            },
          ),
          GoRoute(
            name: AppRouterName.setting.name,
            path: AppRouterName.setting.path,
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: const SettingPage(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        name: AppRouterName.homechecklist.name,
        path: AppRouterName.homechecklist.path,
        pageBuilder: (_, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const HomePageChecklist(),
          );
        },
        routes: [
          GoRoute(
            name: AppRouterName.checklist.name,
            path: AppRouterName.checklist.path,
            pageBuilder: (_, state) {
              return MaterialPage(
                key: state.pageKey,
                child: ChecklistPage(
                  checklist: state.extra as ChecklistModel,
                ),
              );
            },
          ),
        ],
      ),
      GoRoute(
        name: AppRouterName.trash.name,
        path: AppRouterName.trash.path,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const TrashPage(),
          );
        },
      ),
      GoRoute(
        name: AppRouterName.archive.name,
        path: AppRouterName.archive.path,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const ArchivePage(),
          );
        },
      )
    ],
  );

  static GoRouter get router => _router;
}