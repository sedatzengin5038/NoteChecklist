import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterkeepme/core/config/enum/status_Checklist.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/domain/usecases_checklist/get_checklist.dart';


import '../../../../core/core.dart';


part 'search_state_checklist.dart';

class SearchCubitChecklist extends Cubit<SearchStateChecklist> {
  final GetChecklistsUsecase getChecklists;
  SearchCubitChecklist({
    required this.getChecklists,
  }) : super(SearchInitialChecklist());

  void searchFetchChecklist(String query) async {
    emit(SearchLoadingChecklist());

    final failureOrLoaded = await getChecklists();

    failureOrLoaded.fold(
      (failure) => emit(SearchErrorChecklist(_mapFailureMsgChecklist(failure))),
      (listOfChecklists) {
        final List<ChecklistModel> filteredList = listOfChecklists.where((checklist) {
          final bool isInTrash = checklist.stateChecklist == StateChecklist.trash;
          final bool containsQuery =
              checklist.title.toLowerCase().contains(query.toLowerCase()) ||
                  checklist.content.toLowerCase().contains(query.toLowerCase());

          
          return isInTrash ? false : containsQuery;
        }).toList();

        final bool isEmptylistOfNotes = filteredList.isEmpty;

        isEmptylistOfNotes
            ? emit(const EmptySearchChecklist('No matching notes'))
            : emit(SearchLoadedChecklist(filteredList));
      },
    );
  }

  //=> // Map Return : Failure Msg
  String _mapFailureMsgChecklist(Failure failure) {
    switch (failure.runtimeType) {
      case DatabaseFailure:
        return DATABASE_FAILURE_MSG;
      case NoDataFailure:
        return NO_DATA_FAILURE_MSG;
      default:
        return 'Unexpected Error , Please try again later . ';
    }
  }
}
