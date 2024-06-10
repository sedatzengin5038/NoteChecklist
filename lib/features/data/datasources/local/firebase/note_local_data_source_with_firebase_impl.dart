import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '/features/data/datasources/local/note_local_data_source.dart';
import '/features/data/model/note_model.dart';

import '/core/core.dart';


class NoteLocalDataSourceWithFirestoreImpl implements NoteLocalDataSourse {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionNoteModel = 'notes';

  @override
  Future<bool> initDb() async {
    try {
      
      return true;
    } catch (e) {
      throw ConnectionException();
    }
  }

  @override
  Future<List<NoteModel>> getAllNoteModel() async {
    try {
      final querySnapshot = await _firestore.collection('notes').get();
      final NoteModels = querySnapshot.docs
          .map((doc) => NoteModel.fromMap(doc.data()))
          .toList();
        
      return NoteModels;
    } catch (e) {
      throw NoDataException();
    }
  }

  @override
  Future<NoteModel> getNoteModelById(String NoteModelById) async {
    try {
      final docSnapshot = await _firestore.collection(_collectionNoteModel).doc(NoteModelById).get();
      if (!docSnapshot.exists) {
        throw NoDataException();
      }
      return NoteModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> addNoteModel(NoteModel NoteModel) async {
    try {
      await _firestore.collection(_collectionNoteModel).doc(NoteModel.id).set(NoteModel.toMap());
      return unit;
    } catch (e) {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> updateNoteModel(NoteModel NoteModel) async {
    try {
      await _firestore.collection(_collectionNoteModel).doc(NoteModel.id).update(NoteModel.toMap());
      return unit;
    } catch (e) {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> deleteNoteModel(String NoteModelId) async {
    try {
      await _firestore.collection(_collectionNoteModel).doc(NoteModelId).delete();
      return unit;
    } catch (e) {
      throw NoDataException();
    }
  }
}
