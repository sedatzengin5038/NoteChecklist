import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterkeepme/core/config/enum/status_Checklist.dart';

import '/core/util/function/uuid_gen.dart';

class ChecklistModel extends Equatable {
  final String id;
  final String title;
  final String content;
  final int colorIndex;
  final Timestamp modifiedTime;
  final StateChecklist stateChecklist;

  const ChecklistModel({
    required this.id,
    required this.title,
    required this.content,
    required this.colorIndex,
    required this.modifiedTime,
    required this.stateChecklist,
  });

  ChecklistModel.empty({
    String? id = "",
    this.title = '',
    this.content = '',
    Timestamp? modifiedTime,
    this.colorIndex = 0,
    this.stateChecklist = StateChecklist.undefined,
  })  : id = id ?? UUIDGen.generate(),
        modifiedTime = modifiedTime ?? Timestamp.now();

  ChecklistModel copyWith({
    String? id,
    String? title,
    String? content,
    int? colorIndex,
    Timestamp? modifiedTime,
    StateChecklist? stateChecklist,
  }) {
    return ChecklistModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      colorIndex: colorIndex ?? this.colorIndex,
      modifiedTime: modifiedTime ?? this.modifiedTime,
      stateChecklist: stateChecklist ?? this.stateChecklist,
    );
    }

  factory ChecklistModel.fromMap(Map<String, dynamic> map) {
    return ChecklistModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      colorIndex: map['colorIndex'],
      modifiedTime: map['modifiedTime'],
      stateChecklist: StateChecklist.values[map['stateChecklist']],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'colorIndex': colorIndex,
      'modifiedTime': modifiedTime,
      'stateChecklist': stateChecklist.index,
    };
  }

  @override
  List<Object?> get props =>
      [id, title, content, colorIndex, modifiedTime, stateChecklist];
}
