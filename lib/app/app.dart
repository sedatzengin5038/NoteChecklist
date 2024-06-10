import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../../features/presentation/blocs/blocs.dart';

import 'provider/app_provider.dart';

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppDevice.setStatusBart(context);
    return AppProviders( // AppProviders widget'ını kullanarak ChecklistBloc sağlayıcısını ekliyoruz
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            if (state is LoadedTheme) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Note App Version 2',
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: state.themeMode,
                routeInformationParser: AppRouter.router.routeInformationParser,
                routerDelegate: AppRouter.router.routerDelegate,
                routeInformationProvider: AppRouter.router.routeInformationProvider,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
