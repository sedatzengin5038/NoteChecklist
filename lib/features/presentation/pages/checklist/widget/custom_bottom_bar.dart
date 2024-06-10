import 'package:flutter/material.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';

import '/../../../../core/core.dart';

import 'widgets.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar(
    this.checklist,
    this.undoController,
  ) : super(key: null);

  final UndoHistoryController undoController;
  final ChecklistModel checklist;

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  bool isShowUndoRedo = false;

  @override
  void initState() {
    _loadListenerUndo();
    super.initState();
  }

  _loadListenerUndo() {
    widget.undoController.addListener(
      () => setState(
        () => isShowUndoRedo = true,
      ),
    );
  }

  @override
  void dispose() {
    widget.undoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBottomAppBar(
      isShowFAB: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ColorIconNote(
            press: () =>
                _showModalBottomSheet(sheetPopoverType: SheetPopover.coloring),
          ),
          isShowUndoRedo
              ? UndoRedoButtons(undoController: widget.undoController)
              : Text(
                  FormatDateTime.getFormatDateTime(widget.checklist.modifiedTime),
                ),
          MoreIconNote(
            pressMore: () =>
                _showModalBottomSheet(sheetPopoverType: SheetPopover.more),
            pressRecovery: () =>
                _showModalBottomSheet(sheetPopoverType: SheetPopover.recovery),
          )
        ],
      ),
    );
  }

  void _showModalBottomSheet({
    required SheetPopover sheetPopoverType,
  }) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => CommonPopover(
        child: () {
          switch (sheetPopoverType) {
            case SheetPopover.coloring:
              return const PopoverColoringNote();
            case SheetPopover.more:
              return PopoverMoreChecklist(checklist: widget.checklist);
            case SheetPopover.recovery:
              return PopoverRecoveryChecklist(checklist: widget.checklist);
          }
        }(),
      ),
    );
  }
}
