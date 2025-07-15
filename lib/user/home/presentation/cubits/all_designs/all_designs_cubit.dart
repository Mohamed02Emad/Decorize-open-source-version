import 'package:decorizer/common/base/baseCubit.dart';
import 'package:decorizer/common/data/models/image_model.dart';
import 'package:decorizer/common/data/remote/request_state.dart';
import 'package:decorizer/user/home/domain/params/all_designs_params.dart';
import 'package:decorizer/user/home/domain/usecases/all_designs_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import 'all_designs_state.dart';

@injectable
class AllDesignsCubit extends BaseCubit<AllDesignsState> {
  final AllDesignsUsecase allDesignsUsecase;

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<bool> showUpButton = ValueNotifier(false);
  late final PagingController<int, ImageModel> paginateController;

  AllDesignsCubit(this.allDesignsUsecase) : super(AllDesignsState.initial()) {
    scrollController.addListener(_scrollListener);
    paginateController = PagingController(firstPageKey: 1);
    paginateController
        .addPageRequestListener((pageKey) => getAllDesigns(pageKey));
  }

  void startPagination({int? categoryId}) {
    _categoryId = categoryId;
    refresh();
  }

  int? _categoryId;

  Future<void> getAllDesigns(int pageKey) async {
    if (state.allDesignsState.isLoading) return;
    callAndFold(
      future: allDesignsUsecase(AllDesignsParams(
        page: pageKey,
        categoryId: _categoryId,
        query: searchController.text,
      )),
      onDefaultEmit: (requestState) =>
          emit(state.copyWith(allDesignsState: requestState)),
      error: (error) {
        paginateController.error = error;
        emit(state.copyWith(allDesignsState: RequestState.error(error)));
      },
      success: (data) {
        if (data.length < 10) {
          paginateController.appendLastPage(data);
        } else {
          paginateController.appendPage(data, pageKey + 1);
        }
        emit(state.copyWith(
            allDesignsState:
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
