import 'package:dartz/dartz.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/domain/repositories/checklist_repositories.dart';
import '/core/util/errors/failure.dart';

import '../../../core/util/util.dart';


class UpdateChecklistUsecase {
  final ChecklistRepositories checklistRepositories;

  UpdateChecklistUsecase({
    required this.checklistRepositories,
  });

  Future<Either<Failure, Unit>> call(ChecklistModel checklist) async {
    return await checklistRepositories.updateChecklistModel(checklist);
  }
}
