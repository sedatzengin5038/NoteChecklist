import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutterkeepme/features/data/datasources/local/checklist_local_data_source.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';



import '/core/core.dart';


class ChecklistLocalDataSourceWithFirestoreImpl implements ChecklistLocalDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionChecklistModel = 'Checklists';

  @override
  Future<bool> initDb() async {
    try {
      
      return true;
    } catch (e) {
      throw ConnectionException();
    }
  }

  @override
  Future<List<ChecklistModel>> getAllChecklistModel() async {
    try {
      final querySnapshot = await _firestore.collection('Checklists').get();
      final ChecklistModels = querySnapshot.docs
          .map((doc) => ChecklistModel.fromMap(doc.data()))
          .toList();
        
      return ChecklistModels;
    } catch (e) {
      throw NoDataException();
    }
  }

  @override
  Future<ChecklistModel> getChecklistModelById(String checklistModelById) async {
    try {
      final docSnapshot = await _firestore.collection(_collectionChecklistModel).doc(checklistModelById).get();
      if (!docSnapshot.exists) {
        throw NoDataException();
      }
      return ChecklistModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> addChecklistModel(ChecklistModel checklistModel) async {
    try {
      await _firestore.collection(_collectionChecklistModel).doc(checklistModel.id).set(checklistModel.toMap());
      return unit;
    } catch (e) {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> updateChecklistModel(ChecklistModel checklistModel) async {
    try {
      await _firestore.collection(_collectionChecklistModel).doc(checklistModel.id).update(checklistModel.toMap());
      return unit;
    } catch (e) {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> deleteChecklistModel(String checklistModelId) async {
    try {
      await _firestore.collection(_collectionChecklistModel).doc(checklistModelId).delete();
      return unit;
    } catch (e) {
      throw NoDataException();
    }
  }
}
