import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/widget/app_title_bar.dart';
import 'package:decorizer/shared_features/static/presentation/cubits/cities/cities_cubit.dart';
import 'package:decorizer/shared_features/static/presentation/cubits/governates/governates_cubit.dart';
import 'package:decorizer/shared_features/static/presentation/cubits/types/types_cubit.dart';
import 'package:decorizer/user/create_ad/presentation/cubits/upsert_ad/upsert_ad_cubit.dart';
import 'package:decorizer/user/orders/domain/models/order_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/di/injection_container.dart';
import 'package:decorizer/user/create_ad/presentation/widgets/upsert_ad_form.dart';

class UpsertAdScreen extends StatelessWidget {
  final OrderDetailsModel? orderDetailsModel;

  const UpsertAdScreen({
    super.key,
    this.orderDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    final isUpdating = orderDetailsModel != null;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UpsertAdCubit>()..initData(orderDetailsModel),
        ),
        BlocProvider(create: (context) => sl<TypesCubit>()..getTypes()),
        BlocProvider(
            create: (context) => sl<GovernatesCubit>()..getGovernorates()),
        BlocProvider(create: (context) => sl<CitiesCubit>()),
      ],
      child: Scaffold(
        appBar: AppTitleBar(
          hasBackButton: true,
          title: isUpdating ? LocaleKeys.create_ad_update_ad.tr() : LocaleKeys.create_ad_create_ad.tr(),
        ),
        body: UpsertAdForm(orderDetailsModel: orderDetailsModel),
      ),
    );
  }
}
