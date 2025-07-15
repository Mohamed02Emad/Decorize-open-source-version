import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/util/get_file/pick_file_util.dart';
import 'package:decorizer/user/home/presentation/cubits/home/home_cubit.dart';
import 'package:decorizer/user/home/presentation/widgets/sections/categories_list.dart';
import 'package:decorizer/user/home/presentation/widgets/sections/designs_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestedDesignsSection extends StatelessWidget {
  const SuggestedDesignsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      final images = state.categoriesImagesState.data ?? [];
      final selectedCategory = context.read<HomeCubit>().selectedCategory.value;
      return Column(
        children: [
          const CategoriesList(),
          16.gap,
          DesignsGrid(
            designs: images.map((image) => image.url).toList(),
            isLoading: state.isCategoriesListLoading,
            category: selectedCategory,
            onDesignTap: (design) => _openDesign(context, design),
          ),
        ],
      )
          .withTitle(title: LocaleKeys.home_suggested_designs)
          .marginTop( 12.h);
    });
  }

  void _openDesign(BuildContext context, String design) {
    PickFileUtil.showFileSelected(url: design, heroTag: "design_$design");
  }
}
