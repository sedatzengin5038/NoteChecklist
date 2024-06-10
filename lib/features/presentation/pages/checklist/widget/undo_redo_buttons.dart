import 'package:flutter/material.dart';
import 'package:flutterkeepme/core/util/constants/icons/app_icons.dart';


class UndoRedoButtons extends StatelessWidget {
  const UndoRedoButtons({
    Key? key,
    required this.undoController,
  }) : super(key: key);

  final UndoHistoryController undoController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UndoHistoryValue>(
      valueListenable: undoController,
      builder: (_, value, __) {
        return Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: Opacity(
                opacity: value.canUndo ? 1.0 : 0.5,
                child: AppIcons.undo,
              ),
              onPressed: () => undoController.undo(),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon: Opacity(
                opacity: value.canRedo ? 1.0 : 0.5,
                child: AppIcons.rede,
              ),
              onPressed: () => undoController.redo(),
            ),
          ],
        );
      },
    );
  }
}
