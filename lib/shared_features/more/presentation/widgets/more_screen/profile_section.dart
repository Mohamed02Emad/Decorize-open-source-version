import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/shared_features/auth/domain/enums/user_type.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import 'package:decorizer/worker/profile/presentation/screens/worker_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/constant/textStyles.dart';
import '../../../../../common/widget/app/app_image.dart';
import '../../../../../common/widget/app/floating_card.dart';
import '../../../../../user/edit_profile/presentation/pages/user_edit_profile_screen.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LoginInfoCubit, LoginInfoState>(
      builder: (context, state) => FloatingCard(
        onClick: () => _openProfile(context),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        shadowColor: context.appColors.shadowColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppImage(
              path: state.userState.data?.image ?? 'error',
              width: 45.w,
              height: 45.w,
              radius: 45.w,
            ),
            8.h.gap,
            Text(
              state.userState.data?.name ?? 'name loading',
              style: TextStyles.bold14(),
            ),
          ],
        ),
      ),
    );
  }

  void _openProfile(BuildContext context) {
    final userType = context.currentUserType;
    switch (userType) {
      case UserType.user:
        Nav.push(UserEditProfileScreen());
        break;
      case UserType.worker:
        Nav.push(WorkerProfileScreen());
        break;
      case null:
      // TODO: Handle this case.
    }
  }
}
