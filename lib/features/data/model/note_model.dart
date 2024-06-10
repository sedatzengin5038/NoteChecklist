import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '/core/config/enum/status_note.dart';
import '/core/util/function/uuid_gen.dart';

class NoteModel extends Equatable {
  final String id;
  final String title;
  final String content;
  final int colorIndex;
  final Timestamp modifiedTime;
  final StateNote stateNote;

  const NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.colorIndex,
    required this.modifiedTime,
    required this.stateNote,
  });

  NoteModel.empty({
    String? id,
    this.title = '',
    this.content = '',
    Timestamp? modifiedTime,
    this.colorIndex = 0,
    this.stateNote = StateNote.undefined,
  })  : id = id ?? UUIDGen.generate(),
        modifiedTime = modifiedTime ?? Timestamp.now();

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    int? colorIndex,
    Timestamp? modifiedTime,
    StateNote? stateNote,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      colorIndex: colorIndex ?? this.colorIndex,
      modifiedTime: modifiedTime ?? this.modifiedTime,
      stateNote: stateNote ?? this.stateNote,
    );
    }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      colorIndex: map['colorIndex'],
      modifiedTime: map['modifiedTime'],
      stateNote: StateNote.values[map['stateNote']],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'colorIndex': colorIndex,
      'modifiedTime': modifiedTime,
      'stateNote': stateNote.index,
    };
  }

  @override
  List<Object?> get props =>
      [id, title, content, colorIndex, modifiedTime, stateNote];
}
