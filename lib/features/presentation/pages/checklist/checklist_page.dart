import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/config/enum/status_Checklist.dart';
import 'package:flutterkeepme/core/util/function/color_checklist.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';
import 'package:flutterkeepme/features/presentation/blocs/status_icons_Note/status_icons_cubit.dart';
import 'package:flutterkeepme/features/presentation/blocs/status_icons_checklist/status_icons_cubit_checklist.dart';
import 'package:go_router/go_router.dart';


import 'widget/widgets.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({
    super.key,
    required this.checklist,
  });

  final ChecklistModel checklist;

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _undoController = UndoHistoryController();

  Color get checklistColor {
    final checklistBloc = context.read<ChecklistBloc>();
    return ColorChecklist.getColor(context, checklistBloc.currentColor);
  }

  ChecklistModel get originNote {
    return ChecklistModel(
      id: widget.checklist.id,
      title: widget.checklist.title,
      content: widget.checklist.content,
      modifiedTime: widget.checklist.modifiedTime,
      colorIndex: widget.checklist.colorIndex,
      stateChecklist: widget.checklist.stateChecklist,
    );
  }

  ChecklistModel get currentChecklist {
    final checklistBloc = context.read<ChecklistBloc>();
    final checklistStatusBloc = context.read<StatusIconsCubitChecklist>();
    //==>
    final StateChecklist currentStateChecklist =
        checklistStatusBloc.state is ToggleIconsStatusState
            ? (checklistStatusBloc.state as ToggleIconsStatusStateChecklist).currentChecklistStatus
            : StateChecklist.trash;
    //==>
    return ChecklistModel(
      id: widget.checklist.id,
      title: _titleController.text,
      content: _contentController.text,
      modifiedTime: widget.checklist.modifiedTime,
      colorIndex: checklistBloc.currentColor,
      stateChecklist: currentStateChecklist,
    );
  }

  @override
  void initState() {
    _loadNoteFields();
    super.initState();
  }

  void _loadNoteFields() {
    _titleController.text = widget.checklist.title;
    _contentController.text = widget.checklist.content;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (_) => _onBack(),
      child: BlocConsumer<ChecklistBloc, ChecklistState>(
        listener: (context, state) => _displaylistener(context, state),
        builder: (context, state) {
          return Scaffold(
            backgroundColor: checklistColor,
            bottomNavigationBar: CustomBottomBar(currentChecklist, _undoController),
            appBar: AppBarNote(press: _onBack),
            body: _buildBody(),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: TextFieldsForm(
          controllerTitle: _titleController,
          controllerContent: _contentController,
          undoController: _undoController,
          autofocus: false,
        ),
      ),
    );
  }

  Future<bool> _onBack() async {
    context.read<ChecklistBloc>().add(PopChecklistAction(currentChecklist, originNote));
    return true;
  }

  void _displaylistener(BuildContext context, ChecklistState state) {
  if (state is GoPopChecklistState) {
    // GoRouter'ın pop edebileceği bir durumda mıyız?
    if (GoRouter.of(context).canPop()) {
      // Evet, pop işlemini gerçekleştir.
      context.pop();
    } else {
      // Pop edilebilecek bir şey yok, bir hata durumu olabilir.
      print("There is nothing to pop in GoRouter!");
    }
  }
}

}
