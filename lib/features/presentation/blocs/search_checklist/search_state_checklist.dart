part of 'search_cubit_checklist.dart';

sealed class SearchStateChecklist extends Equatable {
  const SearchStateChecklist();

  @override
  List<Object> get props => [];
}

final class SearchInitialChecklist extends SearchStateChecklist {}

final class SearchLoadingChecklist extends SearchStateChecklist {}

final class SearchErrorChecklist extends SearchStateChecklist {
  final String message;

  const SearchErrorChecklist(this.message);
}

final class SearchLoadedChecklist extends SearchStateChecklist {
  final List<ChecklistModel> checklist;

  const SearchLoadedChecklist(this.checklist);

  @override
  List<Object> get props => [checklist];
}

final class EmptySearchChecklist extends SearchStateChecklist {
  final String message;

  const EmptySearchChecklist(this.message);

  @override
  List<Object> get props => [message];
}
