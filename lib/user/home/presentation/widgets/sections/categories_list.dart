import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/user/home/presentation/cubits/home/home_cubit.dart';
import 'package:decorizer/user/home/presentation/widgets/category_card.dart';
import 'package:decorizer/user/home/presentation/widgets/skeletons/categories_list_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return ValueListenableBuilder(
      valueListenable: cubit.selectedCategory,
      builder: (context, selectedCategory, child) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final categories = state.categoriesState.data ?? [];
            final isLoading = state.categoriesState.isLoading;
            return isLoading
                ? const CategoriesListSkeleton()
                : SizedBox(
                    height: 36.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return CategoryCard(
                          key: ValueKey(category.id),
                          category: category,
                          isSelected: selectedCategory?.id == category.id,
                          onClick: () {
                            cubit.onCategorySelected(category);
                          },
                        ).scaleAppear().marginEnd(8.w);
                      },
                    ),
                  );
          },
        );
      },
    );
  }
}
