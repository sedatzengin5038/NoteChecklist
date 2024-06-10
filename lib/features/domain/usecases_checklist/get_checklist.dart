import 'package:dartz/dartz.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/domain/repositories/checklist_repositories.dart';


import '../../../core/util/util.dart';


class GetChecklistsUsecase {
  final ChecklistRepositories checklistRepositories;

  GetChecklistsUsecase({
    required this.checklistRepositories,
  });

  Future<Either<Failure, List<ChecklistModel>>> call() async {
    //await Future.delayed(const Duration(seconds: 2));
    print("get lists");
    return await checklistRepositories.getAllChecklistModel();
  }
}
