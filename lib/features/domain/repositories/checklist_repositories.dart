import 'package:dartz/dartz.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import '/core/util/errors/failure.dart';

abstract class ChecklistRepositories {
  Future<Either<Failure, List<ChecklistModel>>> getAllChecklistModel();
  Future<Either<Failure, ChecklistModel>> getChecklistModelById(String checklistId);
  Future<Either<Failure, Unit>> addChecklistModel(ChecklistModel checklist);
  Future<Either<Failure, Unit>> updateChecklistModel(ChecklistModel checklist);
  Future<Either<Failure, Unit>> deleteChecklistModel(String checklistId);
}
