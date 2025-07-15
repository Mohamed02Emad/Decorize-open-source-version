import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/shared_features/orders/presentation/widgets/search%20bar/search_button.dart';
import 'package:decorizer/user/orders/presentation/cubits/get_orders/get_user_orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/constant/textStyles.dart';

class OrderScreenSearchBar extends StatelessWidget {
  const OrderScreenSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GetUserOrdersCubit>();
    return Expanded(
      child: SearchBar(
        controller: cubit.searchController,
        onChanged: (value) {
          cubit.searchDebouncer.call(() {
            cubit.refresh();
          });
        },
        shadowColor: WidgetStatePropertyAll(Color.fromARGB(0, 0, 0, 0)),
        backgroundColor: WidgetStatePropertyAll(context.isDarkMode ? context.appColors.onBackground : Colors.white),
        leading: SearchButton(),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
                width: 1, color: context.isDarkMode ? context.appColors.onBackground : Color.fromARGB(255, 230, 230, 230)))),
        hintText: context.tr(LocaleKeys.OrderScreen_search_with_order_number),
        hintStyle: WidgetStatePropertyAll(TextStyles.regular12Weight400(
            color: Color.fromARGB(255, 139, 139, 139), context: context)),
      ),
    );
  }
}
