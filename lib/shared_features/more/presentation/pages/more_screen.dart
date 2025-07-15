import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/data/preference/extentions.dart';
import 'package:decorizer/common/extentions/data_types/double.dart';
import 'package:decorizer/common/util/guest_util.dart';
import 'package:decorizer/common/widget/app_title_bar.dart';
import 'package:decorizer/shared_features/auth/domain/enums/user_type.dart';
import 'package:decorizer/shared_features/more/presentation/widgets/more_screen/policy_and_terms_section.dart';
import 'package:decorizer/shared_features/more/presentation/widgets/more_screen/profile_section.dart';
import 'package:decorizer/user/view_worker_profile/presentation/pages/view_worker_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/di/injection_container.dart';
import '../../../../common/resources/gen/locale_keys.g.dart';
import '../cubits/more/more_cubit.dart';
import '../widgets/more_screen/actions_section.dart';
import '../widgets/more_screen/language_and_contact_us_section.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserType? currentUserType = context.currentUserType;
    return Scaffold(
      appBar: AppTitleBar(title: context.tr(LocaleKeys.bottomNavigation_more)),
      body: BlocProvider(
        create: (context) => sl<MoreCubit>(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              12.h.gap,
              if (GuestUtil.isGuest.not()) const ProfileSection(),
              
              const PolicyAndTermsSection(),
              const LanguageAndContactUsSection(),
              const ActionsSection(),
              ElevatedButton(
                  onPressed: () {
                    Nav.push(const ViewWorkerProfileScreen());
                  },
                  child: Text('remove this button')),
              30.h.gap,
            ],
          ),
        ),
      ),
    );
  }
}
