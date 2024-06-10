import 'package:dartz/dartz.dart';
import 'package:flutterkeepme/features/data/datasources/local/checklist_local_data_source.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/domain/repositories/checklist_repositories.dart';



import '../../../core/util/util.dart';



class ChecklistRepositoriesImpl implements ChecklistRepositories {
  final ChecklistLocalDataSource checklistLocalDataSource;

  ChecklistRepositoriesImpl({
    required this.checklistLocalDataSource,
  });

  @override
  Future<Either<Failure, List<ChecklistModel>>> getAllChecklistModel() async {
    
    try {
      final response = await checklistLocalDataSource.getAllChecklistModel();
      
      return Right(response.cast<ChecklistModel>());
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, ChecklistModel>> getChecklistModelById(String ChecklistId) async {
    try {
      final response = await checklistLocalDataSource.getChecklistModelById(ChecklistId);
      return Right(response as ChecklistModel);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addChecklistModel(ChecklistModel checklist) async {
    try {
      if (checklist.title.isEmpty && checklist.content.isEmpty) {
        return Left(EmpytInputFailure());
      } else {
        final ChecklistModel convertToChecklistModel = ChecklistModel(
          id: checklist.id,
          title: checklist.title,
          content: checklist.content,
          colorIndex: checklist.colorIndex,
          modifiedTime: checklist.modifiedTime,
          stateChecklist: checklist.stateChecklist,
        );
        await checklistLocalDataSource.addChecklistModel(convertToChecklistModel);
        return const Right(unit);
      }
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateChecklistModel(ChecklistModel checklist) async {
    try {
      final ChecklistModel convertToChecklistModel = ChecklistModel(
        id: checklist.id,
        title: checklist.title,
        content: checklist.content,
        colorIndex: checklist.colorIndex,
        modifiedTime: checklist.modifiedTime,
        stateChecklist: checklist.stateChecklist,
      );
      await checklistLocalDataSource.updateChecklistModel(convertToChecklistModel);
      return const Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteChecklistModel(String checklistId) async {
    try {
      await checklistLocalDataSource.deleteChecklistModel(checklistId);
      return const Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

}