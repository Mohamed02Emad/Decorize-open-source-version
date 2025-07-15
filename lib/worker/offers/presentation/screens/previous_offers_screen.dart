import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/widget/app/skeleton.dart';
import '../../../../common/widget/paging/paginated_list_view.dart';
import '../cubit/previous_offers_cubit/previous_offers_cubit.dart';
import '../widgets/worker_offer_card.dart';

class PreviousOffersScreen extends StatelessWidget {
  const PreviousOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PreviousOffersScreenBody();
  }
}

class _PreviousOffersScreenBody extends StatelessWidget {
  const _PreviousOffersScreenBody({super.key});
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        _refresh(context);
      },
      child: PaginatedListView(
        padding: EdgeInsets.only(bottom: 20.h, left: 16.w, right: 16.w),
        pagingController:
            context.read<GetPreviousOffersCubit>().paginateController,
        onRetry: () => _refresh(context),
        itemBuilder: (context, item, index) => WorkerOfferCard(
          offer: item,
        ).fadeScaleAppear(
          startSize: 0.96,
        ),
        loadingItemBuilder: Skeleton.skeletonsList(10,
            width: double.infinity, height: 106.h, radius: 12.r),
      ),
    );
  }

  void _refresh(BuildContext context) {
    context.read<GetPreviousOffersCubit>().refresh();
  }
}
