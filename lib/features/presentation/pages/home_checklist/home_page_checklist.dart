import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/config/drawer/app_drawer.dart';
import 'package:flutterkeepme/core/config/enum/app_routes.dart';
import 'package:flutterkeepme/core/config/enum/drawer_section_view_checklist.dart';
import 'package:flutterkeepme/core/util/function/drawer_select_checklist.dart';
import 'package:flutterkeepme/core/util/util.dart';
import 'package:flutterkeepme/core/widgets/common_checklist_view_checklist.dart';
import 'package:flutterkeepme/core/widgets/common_empty_checklist.dart';
import 'package:flutterkeepme/core/widgets/common_loading_checklist.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';
import 'package:flutterkeepme/features/presentation/blocs/status_icons_checklist/status_icons_cubit_checklist.dart';
import 'package:flutterkeepme/features/presentation/pages/home_checklist/widgets/sliver_checklist.dart';
import 'package:go_router/go_router.dart';




class HomePageChecklist extends StatelessWidget {
  const HomePageChecklist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<ChecklistBloc>().appScaffoldState,
      floatingActionButton: _buildFloatingActionButton(context),
      extendBodyBehindAppBar: true,
      extendBody: true,
      drawer: const AppDrawer(),
      appBar: _buildAppbar(),
      body: _buildBody(context),
    );
    
  }

  AppBar _buildAppbar() => AppBar(toolbarHeight: 0);

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<ChecklistBloc, ChecklistState>(
      listener: (context, state) => _displayChecklistsMsg(context, state),
      builder: (context, state) {
        print(state);
        if (state is LoadingStateChecklist) {
          return CommonLoadingChecklist(state.drawerSectionViewChecklist);
        } else if (state is EmptyChecklistState) {
          
          return CommonEmptyChecklists(state.drawerSectionViewChecklist);
        } else if (state is ErrorState) {
          return CommonEmptyChecklists(state.drawerSectionViewChecklist);
        } else if (state is ChecklistsViewState) {
          
          return SliverChecklists(
            child: CommonChecklistsViewChecklist(
              drawerSection: DrawerSectionViewChecklist.homepagechecklist,
              otherChecklists: state.otherChecklists,
              pinnedChecklists: state.pinnedChecklists,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _displayChecklistsMsg(BuildContext context, ChecklistState state) {
    if (state is SuccessState) {
      context.read<ChecklistBloc>().add(RefreshChecklists(DrawerSelectChecklist.drawerSectionChecklist));
      AppAlerts.displaySnackbarMsg(context, state.message);
    } else if (state is ToggleSuccessState) {
      AppAlerts.displaySnackarUndoMove(context, state.message);
    } else if (state is EmptyInputsState) {
      AppAlerts.displaySnackbarMsg(context, state.message);
    } else if (state is GoPopChecklistState) {
      context.read<ChecklistBloc>().add(RefreshChecklists(DrawerSelectChecklist.drawerSectionChecklist));
    } else if (state is GetChecklistByIdState) {
      _getChecklistByIdState(context, state.checklist);
    }
  }

  void _getChecklistByIdState(BuildContext context, ChecklistModel checklist) {
    context.read<StatusIconsCubitChecklist>().toggleIconsStatusChecklist(checklist);
    context.read<ChecklistBloc>().add(ModifColorChecklist(checklist.colorIndex));
    print(checklist);
    context.pushNamed(
      AppRouterName.checklist.name,
      pathParameters: {'checklistId': checklist.id},
      extra: checklist,
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: AppIcons.add,
      onPressed: () {
        print(context.read<ChecklistBloc>().getChecklists);
         context.read<ChecklistBloc>().add(const GetChecklistModelById(''));
      }
    );
  }
}
