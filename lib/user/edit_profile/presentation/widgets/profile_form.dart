import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/data_types/int.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:decorizer/user/edit_profile/presentation/pages/change_password_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/user/edit_profile/presentation/cubits/update_profile/update_profile_cubit.dart';
import 'package:decorizer/user/edit_profile/presentation/widgets/profile_form_fields.dart';
import 'package:decorizer/user/edit_profile/presentation/widgets/profile_image_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileForm extends StatelessWidget {
  final dynamic user;

  const ProfileForm({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      builder: (context, updateState) {
        final cubit = context.read<UpdateProfileCubit>();

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              6.gap,
              ProfileImageSection(
                profileImage: updateState.profileImage,
                profileImageUrl: updateState.profileImageUrl,
                onImageSelected: (file) => cubit.updateProfileImage(file),
              ),
              ProfileFormFields(
                user: user,
                name: updateState.name,
                email: updateState.email,
                phone: updateState.phone,
                password: updateState.password,
                onNameChanged: (value) => cubit.updateName(value),
                onEmailChanged: (value) => cubit.updateEmail(value),
                onPhoneChanged: (value) => cubit.updatePhone(value),
                onPasswordChanged: (value) => cubit.updatePassword(value),
                onChangePasswordClicked: () => _changePasswordClicked(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _changePasswordClicked(BuildContext context) {
    Nav.push(const ChangePasswordScreen());
  }
}
