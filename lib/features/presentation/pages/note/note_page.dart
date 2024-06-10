import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/data/model/note_model.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import '../../blocs/blocs.dart';
import 'widget/widgets.dart';

class NotePage extends StatefulWidget {
  const NotePage({
    super.key,
    required this.note,
  });

  final NoteModel note;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _undoController = UndoHistoryController();

  Color get noteColor {
    final noteBloc = context.read<NoteBloc>();
    return ColorNote.getColor(context, noteBloc.currentColor);
  }

  NoteModel get originNote {
    return NoteModel(
      id: widget.note.id,
      title: widget.note.title,
      content: widget.note.content,
      modifiedTime: widget.note.modifiedTime,
      colorIndex: widget.note.colorIndex,
      stateNote: widget.note.stateNote,
    );
  }

  NoteModel get currentNote {
    final noteBloc = context.read<NoteBloc>();
    final noteStatusBloc = context.read<StatusIconsCubit>();
    //==>
    final StateNote currentStateNote =
        noteStatusBloc.state is ToggleIconsStatusState
            ? (noteStatusBloc.state as ToggleIconsStatusState).currentNoteStatus
            : StateNote.trash;
    //==>
    return NoteModel(
      id: widget.note.id,
      title: _titleController.text,
      content: _contentController.text,
      modifiedTime: widget.note.modifiedTime,
      colorIndex: noteBloc.currentColor,
      stateNote: currentStateNote,
    );
  }

  @override
  void initState() {
    _loadNoteFields();
    super.initState();
  }

  void _loadNoteFields() {
    _titleController.text = widget.note.title;
    _contentController.text = widget.note.content;
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
      child: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) => _displaylistener(context, state),
        builder: (context, state) {
          return Scaffold(
            backgroundColor: noteColor,
            bottomNavigationBar: CustomBottomBar(currentNote, _undoController),
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
    context.read<NoteBloc>().add(PopNoteAction(currentNote, originNote));
    return true;
  }

  void _displaylistener(BuildContext context, NoteState state) {
  if (state is GoPopNoteState) {
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
