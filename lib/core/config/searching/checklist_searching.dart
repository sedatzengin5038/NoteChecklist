import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/presentation/blocs/search_checklist/search_cubit_checklist.dart';
import 'package:flutterkeepme/features/presentation/pages/home_checklist/widgets/widgets_checklist.dart';

import '../../util/util.dart';

class ChecklistsSearching extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Search your checklist';

  @override
  TextStyle? get searchFieldStyle => const TextStyle().copyWith(fontSize: 18.0);
  
  @override
  List<Widget>? buildActions(BuildContext context) => query.isNotEmpty
      ? [IconButton(onPressed: () => query = '', icon: const Icon(Icons.close))]
      : [];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.navigate_before),
      );

  @override
  Widget buildResults(BuildContext context) => _buildSearchResultsChecklist(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResultsChecklist(context);

  Widget _buildSearchResultsChecklist(BuildContext context) {
    if (query.isEmpty) return const SizedBox.shrink();

    context.read<SearchCubitChecklist>().searchFetchChecklist(query);

    return BlocBuilder<SearchCubitChecklist, SearchStateChecklist>(
      builder: (context, state) {
        if (state is SearchLoadingChecklist) {
          return _buildLoadingIndicator();
        } else if (state is SearchLoadedChecklist) {
          return _buildSearchLoaded(state.checklist);
        } else if (state is EmptySearchChecklist) {
          return _buildEmptySearch(state.message);
        } else if (state is SearchErrorChecklist) {
          return _buildSearchError(state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchLoaded(List<ChecklistModel> checklists) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        GridNotesChecklist(checklist: checklists, isShowDismisse: false),
      ],
    );
  }

  Widget _buildEmptySearch(String meassge) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [AppIcons.emptySearch, Text(meassge)],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchError(String meassge) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [AppIcons.error, Text(meassge)],
          ),
        ),
      ],
    );
  }
  
}