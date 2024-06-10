import 'package:dartz/dartz.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';





abstract class ChecklistLocalDataSource {
  Future<bool> initDb();
  Future<List<ChecklistModel>> getAllChecklistModel();
  Future<ChecklistModel> getChecklistModelById(String checklistModelById);
  Future<Unit> addChecklistModel(ChecklistModel checklistModel);
  Future<Unit> updateChecklistModel(ChecklistModel checklistModel);
  Future<Unit> deleteChecklistModel(String checklistModelId);
}
