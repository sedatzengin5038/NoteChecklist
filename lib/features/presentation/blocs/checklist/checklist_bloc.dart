import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterkeepme/core/config/enum/drawer_section_view_checklist.dart';
import 'package:flutterkeepme/core/config/enum/status_Checklist.dart';
import 'package:flutterkeepme/features/data/model/checklist_model.dart';
import 'package:flutterkeepme/features/domain/usecases_checklist/add_checklist.dart';
import 'package:flutterkeepme/features/domain/usecases_checklist/delete_checklist.dart';
import 'package:flutterkeepme/features/domain/usecases_checklist/get_checklist.dart';
import 'package:flutterkeepme/features/domain/usecases_checklist/get_checklist_by_id.dart';
import 'package:flutterkeepme/features/domain/usecases_checklist/update_checklist.dart';
import '../../../../core/core.dart';

part 'checklist_event.dart';
part 'checklist_state.dart';

class ChecklistBloc extends Bloc<ChecklistEvent, ChecklistState> {
  final GetChecklistsUsecase getChecklists;
  final GetChecklistByIdUsecase getChecklistById;
  final AddChecklistUsecase addChecklist;
  final UpdateChecklistUsecase updateChecklist;
  final DeleteChecklistUsecase deleteChecklist;

  ChecklistBloc({
    required this.getChecklists,
    required this.getChecklistById,
    required this.addChecklist,
    required this.updateChecklist,
    required this.deleteChecklist,
  }) : super(LoadingStateChecklist(
            DrawerSelect.drawerSection)) {
    on<LoadChecklists>(_onLoadChecklists);
    on<AddChecklist>(_onAddChecklist);
    on<GetChecklistModelById>(_onGetById);
    on<UpdateChecklist>(_onUpdateChecklist);
    on<DeleteChecklist>(_onDeleteChecklist);
    on<RefreshChecklists>(_onRefreshChecklists);
    on<ModifColorChecklist>(_onModifColorChecklist);
    on<EmptyInputs>(_onEmptyInputs);
    // Action Event
    on<MoveChecklist>(_onMoveChecklist);
    on<UndoMoveChecklist>(_onUndoMoveChecklist);
    on<PopChecklistAction>(_onPopChecklistAction);
    // ===
  }

  ChecklistModel? oldChecklist;
  bool _isNewChecklist = false;
  int _colorIndex = 0;
  int get currentColor => _colorIndex;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  GlobalKey<ScaffoldState> get appScaffoldState => _key;

  _onLoadChecklists(LoadChecklists event, Emitter<ChecklistState> emit) async {
    print('Loading checklists...');
    emit(LoadingStateChecklist(event.drawerSectionView));

    final failureOrLoaded = await getChecklists();
    print('Checklists loaded: $failureOrLoaded');

    // Simulating network delay
    await Future.delayed(const Duration(seconds: 2));

    emit(_mapLoadChecklistsState(
        failureOrLoaded, event.drawerSectionView));
  }

  _onRefreshChecklists(
      RefreshChecklists event, Emitter<ChecklistState> emit) async {
    print('Refreshing checklists...');
    emit(LoadingStateChecklist(event.drawerSectionView));

    final failureOrLoaded = await getChecklists();
    print(failureOrLoaded);
    emit(_mapLoadChecklistsState(
        failureOrLoaded, event.drawerSectionViewCheclist));
  }

  _onAddChecklist(AddChecklist event, Emitter<ChecklistState> emit) async {
    final Either<Failure, Unit> failureOrSuccess =
        await addChecklist(event.checklist);
    emit(
      failureOrSuccess.fold(
        (failure) => (ErrorState(
          _mapFailureMsg(failure),
          DrawerSelect.drawerSection,
        )),
        (_) => (const SuccessState(ADD_SUCCESS_MSG)),
      ),
    );
  }

  _onEmptyInputs(EmptyInputs event, Emitter<ChecklistState> emit) {
    emit(const EmptyInputsState(EMPTY_TEXT_MSG));
  }

  _onGetById(GetChecklistModelById event, Emitter<ChecklistState> emit) async {
    final failureOrSuccess = await getChecklistById(event.checklistId);
    emit(
      failureOrSuccess.fold(
        (_) {
          _isNewChecklist = true;
          return GetChecklistByIdState(ChecklistModel.empty());
        },
        (checklist) {
          _isNewChecklist = false;
          return GetChecklistByIdState(checklist);
        },
      ),
    );
  }

  _onUpdateChecklist(
      UpdateChecklist event, Emitter<ChecklistState> emit) async {
    final Either<Failure, Unit> failureOrSuccess =
        await updateChecklist(event.checklist);
    emit(
      failureOrSuccess.fold(
        (failure) => (ErrorState(
          _mapFailureMsg(failure),
          DrawerSelect.drawerSection,
        )),
        (_) => (const SuccessState(UPDATE_SUCCESS_MSG)),
      ),
    );
  }

  _onDeleteChecklist(
      DeleteChecklist event, Emitter<ChecklistState> emit) async {
    final failureOrSuccess = await deleteChecklist(event.checklistId);
    emit(
      failureOrSuccess.fold(
        (failure) => (ErrorState(
          _mapFailureMsg(failure),
          DrawerSelect.drawerSection,
        )),
        (_) => (const SuccessState(DELETE_SUCCESS_MSG)),
      ),
    );
    emit(GoPopChecklistState());
  }

  _onModifColorChecklist(
      ModifColorChecklist event, Emitter<ChecklistState> emit) {
    _colorIndex = event.colorIndex;
    emit(ModifedColorChecklistState(_colorIndex));
  }

  _onPopChecklistAction(
      PopChecklistAction event, Emitter<ChecklistState> emit) async {
    final ChecklistModel currentChecklist = event.currentChecklist;
    final ChecklistModel originChecklist = event.originChecklist;

    // Check if the Checklist is dirty (requires update)
    final bool isDirty = currentChecklist != originChecklist;

    // Set the modified time
    final ChecklistModel updatedChecklist =
        currentChecklist.copyWith(modifiedTime: Timestamp.now());

    // Check if the Checklist is empty
    final bool isChecklistEmpty =
        currentChecklist.title.isEmpty && currentChecklist.content.isEmpty;

    if (_isNewChecklist && isChecklistEmpty) {
      // New Checklist is empty, emit an empty input state
      add(EmptyInputs());
    } else if (_isNewChecklist || (!_isNewChecklist && isDirty)) {
      // Existing Checklist is dirty, update the Checklist
      _isNewChecklist
          ? add(AddChecklist(currentChecklist))
          : add(UpdateChecklist(updatedChecklist));
    }

    // Notify to close the details page
    emit(GoPopChecklistState());
  }

  _onMoveChecklist(MoveChecklist event, Emitter<ChecklistState> emit) async {
    final bool existsChecklist = event.checklist != null;
    final StateChecklist newStatus = event.newStatus;

    if (!existsChecklist) {
      emit(const EmptyInputsState(EMPTY_TEXT_MSG));
      emit(GoPopChecklistState());
      return;
    }

    oldChecklist = event.checklist!;

    Future<ChecklistState> updateChecklistAndEmit({
      required StateChecklist stateChecklist,
      required ChecklistState successState,
    }) async {
      final updatedChecklist = event.checklist!.copyWith(
        stateChecklist: stateChecklist,
        modifiedTime: Timestamp.now(),
      );

      final failureOrSuccess = await updateChecklist(updatedChecklist);

      return failureOrSuccess.fold(
        (failure) => ErrorState(
          _mapFailureMsg(failure),
          DrawerSelect.drawerSection,
        ),
        (_) => successState,
      );
    }

    Future<ChecklistState>? newState;

    switch (newStatus) {
      case StateChecklist.archived:
        newState = updateChecklistAndEmit(
          stateChecklist: newStatus,
          successState: ToggleSuccessState(
            event.checklist!.stateChecklist == StateChecklist.pinned
                ? CHECKLIST_ARCHIVE_WITH_UNPINNED_MSG
                : CHECKLIST_ARCHIVE_MSG,
          ),
        );
        break;
      case StateChecklist.undefined:
        newState = updateChecklistAndEmit(
          stateChecklist: newStatus,
          successState: const ToggleSuccessState(CHECKLIST_UNARCHIVED_MSG),
        );
        break;
      case StateChecklist.trash:
        newState = updateChecklistAndEmit(
          stateChecklist: newStatus,
          successState: const ToggleSuccessState(CHECKLIST_NOTE_TRASH_MSG),
        );
        break;
      case StateChecklist.pinned:
        break;

      default:
        return StateChecklist.undefined;
    }
    emit(await newState!);
    emit(GoPopChecklistState());
  }

  _onUndoMoveChecklist(
      UndoMoveChecklist event, Emitter<ChecklistState> emit) async {
    await updateChecklist(oldChecklist!);
    emit(GoPopChecklistState());
  }

  //===================> <======================//
  //=> // Map Return : Pin Checklists || Not Pin Checklists(Other Checklists) || Empty Checklists
  ChecklistState _mapLoadChecklistsState(
    Either<Failure, List<ChecklistModel>> either,
    DrawerSectionViewChecklist drawerSectionViewChecklist,
  ) {
    return either.fold(
      (failure) {
        return (ErrorState(
          _mapFailureMsg(failure),
          DrawerSelect.drawerSection,
        ));
      },
      (checklists) {
        checklists.sort((a, b) => b.modifiedTime.compareTo(a.modifiedTime));
        List<ChecklistModel> filterChecklistsByState(
            List<ChecklistModel> checklists, StateChecklist state) {
          return checklists
              .where((checklist) => checklist.stateChecklist == state)
              .toList();
        }

        final pinnedChecklists =
            filterChecklistsByState(checklists, StateChecklist.pinned);
        final undefinedChecklists =
            filterChecklistsByState(checklists, StateChecklist.undefined);
        final archiveChecklists =
            filterChecklistsByState(checklists, StateChecklist.archived);
        final trashChecklists =
            filterChecklistsByState(checklists, StateChecklist.trash);

        bool hasPinnedChecklists = pinnedChecklists.isEmpty;
        bool hasUndefinedChecklists = undefinedChecklists.isEmpty;
        bool hasArchiveChecklists = archiveChecklists.isEmpty;
        bool hasTrashChecklists = trashChecklists.isEmpty;

        switch (drawerSectionViewChecklist) {
          case DrawerSectionViewChecklist.homepagechecklist:
          case DrawerSectionViewChecklist.home:
            if (checklists.isEmpty ||
                (!hasUndefinedChecklists && !hasPinnedChecklists)) {
              return EmptyChecklistState(drawerSectionViewChecklist);
            }
            return hasPinnedChecklists
                ? ChecklistsViewState(undefinedChecklists, pinnedChecklists)
                : ChecklistsViewState(undefinedChecklists, const []);

          case DrawerSectionViewChecklist.archive:
            if (checklists.isEmpty || (!hasArchiveChecklists)) {
              return EmptyChecklistState(drawerSectionViewChecklist);
            }
            return ChecklistsViewState(archiveChecklists, const []);

          case DrawerSectionViewChecklist.trash:
            if (checklists.isEmpty || (!hasTrashChecklists)) {
              return EmptyChecklistState(drawerSectionViewChecklist);
            }
            return ChecklistsViewState(trashChecklists, const []);

          default:
            return ErrorState(
              'Unhandled drawer section view checklist: $drawerSectionViewChecklist',
              DrawerSelect.drawerSection,
            );
        }
      },
    );
  }

  //=> // Map Return : Failure Msg
  String _mapFailureMsg(Failure failure) {
    switch (failure.runtimeType) {
      case DatabaseFailure:
        return DATABASE_FAILURE_MSG;
      case NoDataFailure:
        return NO_DATA_FAILURE_MSG;
      default:
        return 'Unexpected Error, Please try again later.';
    }
  }
}
