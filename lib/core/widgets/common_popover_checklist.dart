import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/util/function/color_checklist.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';


class CommonPopoverChecklist extends StatelessWidget {
  final Widget child;

  const CommonPopoverChecklist({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChecklistBloc, ChecklistState>(
      builder: (context, state) {
        int colorIndex = context.read<ChecklistBloc>().currentColor;
        if (state is ModifedColorChecklistState) {
          colorIndex = state.colorIndex;
        }
        return Container(
          color: ColorChecklist.getColor(context, colorIndex),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHandle(context),
              child,
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHandle(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      widthFactor: 0.08,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: theme.dividerColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(2.5),
            ),
          ),
        ),
      ),
    );
  }
}
