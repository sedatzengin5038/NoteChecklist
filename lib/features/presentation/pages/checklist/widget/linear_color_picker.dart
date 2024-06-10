import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/util/constants/icons/app_icons.dart';
import 'package:flutterkeepme/core/util/function/color_checklist.dart';
import 'package:flutterkeepme/features/presentation/blocs/checklist/checklist_bloc.dart';


class LinearColorPicker extends StatelessWidget {
  const LinearColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChecklistBloc, ChecklistState>(
      buildWhen: (previous, current) => current is ModifedColorChecklistState,
      builder: (context, state) {
        int currentColor = context.read<ChecklistBloc>().currentColor;
        if (state is ModifedColorChecklistState) {
          currentColor = state.colorIndex;
        }
        return SizedBox(
          height: 50,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...ColorChecklist.allColorsChecklist(context)
                    .asMap()
                    .entries
                    .map((entry) {
                  final int itemIndex = entry.key;
                  final Color itemColor = entry.value;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: itemIndex == currentColor ? 2.0 : 0.7,
                            color: Colors.blueAccent,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: itemColor,
                          child: _getIconChild(itemIndex, currentColor),
                        ),
                      ),
                      onTap: () => _onTapColor(context, itemIndex),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onTapColor(BuildContext context, int itemIndex) =>
      context.read<ChecklistBloc>().add(ModifColorChecklist(itemIndex));

  Icon? _getIconChild(int index, int currentSelectedColor) {
    if (index == 0) {
      return currentSelectedColor == 0
          ? AppIcons.check
          : AppIcons.defuaulCheckColor;
    } else {
      return index == currentSelectedColor ? AppIcons.check : null;
    }
  }
}
