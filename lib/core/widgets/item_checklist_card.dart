// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';



class ItemChecklistCard extends StatelessWidget {
  final ChecklistModel checklist;

  const ItemChecklistCard({super.key, required this.checklist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            checklist.title.length <= 80
                ? checklist.title
                : '${checklist.title.substring(0, 80)} ...',
            style: const TextStyle().copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Text(
          checklist.content.length <= 180
              ? checklist.content
              : '${checklist.content.substring(0, 180)} ...',
        ),
        //leading: Text(itemNote.id.toString()),
      ),
    );
  }
}
