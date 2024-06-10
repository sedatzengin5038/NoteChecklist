import 'package:dartz/dartz.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/domain/repositories/checklist_repositories.dart';


import '../../../core/core.dart';



class GetChecklistByIdUsecase {
  final ChecklistRepositories checklistRepositories;
  GetChecklistByIdUsecase({
    required this.checklistRepositories,
  });

  Future<Either<Failure, ChecklistModel>> call(String ChecklistId) async {
    print(ChecklistId);
    return await checklistRepositories.getChecklistModelById(ChecklistId);
  }
}
