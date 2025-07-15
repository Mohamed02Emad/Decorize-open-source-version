import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/di/injection_container.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/util/system_bars_util.dart';
import 'package:decorizer/common/widget/app_title_bar.dart';
import 'package:decorizer/shared_features/auth/presentation/cubit/login_info/login_info_cubit.dart';
import 'package:decorizer/user/edit_profile/presentation/cubits/update_profile/update_profile_cubit.dart';
import 'package:decorizer/user/edit_profile/presentation/cubits/get_profile/get_profile_cubit.dart';
import 'package:decorizer/user/edit_profile/presentation/widgets/profile_form.dart';
import 'package:decorizer/user/edit_profile/presentation/widgets/profile_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserEditProfileScreen extends StatefulWidget {
  const UserEditProfileScreen({super.key});

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // Set system bars color
    SystemBarsUtil.changeNavigationBar(context.appColors.background);
    final currentUser = context.read<LoginInfoCubit>().user;
    if (currentUser == null) {
      Nav.pop(context);
      return const SizedBox.shrink();
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                sl<GetProfileCubit>()..getProfile(currentUser.id.toString())),
        BlocProvider(create: (context) => sl<UpdateProfileCubit>()),
      ],
      child: Scaffold(
        appBar: AppTitleBar(
          title: context.tr(LocaleKeys.edit_profile_profile),
          hasBackButton: true,
        ),
        backgroundColor: context.appColors.background,
        body: BlocListener<GetProfileCubit, GetProfileState>(
          listener: (context, state) {
            // When profile loads successfully, initialize the update cubit
            if (state.getProfileState.isSuccess) {
              final user = state.getProfileState.data;
              if (user != null) {
                context.read<UpdateProfileCubit>().initializeFields(user);
              }
            }
          },
          child: BlocBuilder<GetProfileCubit, GetProfileState>(
            builder: (context, state) {
              return state.getProfileState.build(
                successBuilder: (user) => ProfileForm(user: user),
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const ProfileSaveButton(),
      ),
    );
  }
}
