import 'package:dartz/dartz.dart';
import 'package:flutterkeepme/features/domain/repositories/checklist_repositories.dart';

import '../../../core/util/util.dart';

class DeleteChecklistUsecase {
  final ChecklistRepositories checklistRepositories;
  DeleteChecklistUsecase({
    required this.checklistRepositories,
  });

  Future<Either<Failure, Unit>> call(String checklistId) async {
    return await checklistRepositories.deleteChecklistModel(checklistId);
  }
}
