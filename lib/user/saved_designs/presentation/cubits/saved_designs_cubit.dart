import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/common/util/guest_util.dart';
import 'package:decorizer/user/saved_designs/domain/params/get_saved_designs_params.dart';
import 'package:decorizer/user/saved_designs/domain/usecases/get_saved_designs_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import 'saved_designs_state.dart';

@injectable
class SavedDesignsCubit extends BaseCubit<SavedDesignsState> {
  final GetSavedDesignsUsecase getSavedDesignsUsecase;

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<bool> showUpButton = ValueNotifier(false);
  late final PagingController<int, ImageModel> paginateController;

  SavedDesignsCubit(this.getSavedDesignsUsecase)
      : super(SavedDesignsState.initial()) {
    scrollController.addListener(_scrollListener);
    paginateController = PagingController(firstPageKey: 1);
    paginateController
        .addPageRequestListener((pageKey) => getSavedDesigns(pageKey));
  }

  void startPagination() {
    if (GuestUtil.isGuest) return;
    refresh();
  }

  Future<void> getSavedDesigns(int pageKey) async {
    if (state.savedDesignsState.isLoading || GuestUtil.isGuest) return;
    callAndFold(
      future: getSavedDesignsUsecase(GetSavedDesignsParams(
        page: pageKey,
        query: searchController.text,
      )),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(savedDesignsState: requestState)),
      error: (error) {
        paginateController.error = error;
        emit(state.copyWith(savedDesignsState: RequestState.error(error)));
      },
      success: (data) {
        if (data.length < 10) {
          paginateController.appendLastPage(data);
        } else {
          paginateController.appendPage(data, pageKey + 1);
        }
        emit(state.copyWith(
            savedDesignsState:
                RequestState.success(paginateController.itemList ?? [])));
      },
    );
  }

  void refresh() async {
    paginateController.refresh();
  }

  void _scrollListener() {
    double offset = scrollController.offset;
    final newShowButton = offset > 320;
    if (newShowButton != showUpButton.value) {
      showUpButton.value = newShowButton;
    }
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutBack,
    );
  }
}
