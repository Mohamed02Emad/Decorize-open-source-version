import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/constant/textStyles.dart';
import '../../../../common/widget/app/app_button.dart';
import '../../../auth/domain/enums/user_type.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import '../widgets/user_type_card.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _UserTypeScreenBody();
  }
}

class _UserTypeScreenBody extends StatefulWidget {
  const _UserTypeScreenBody();

  @override
  State<_UserTypeScreenBody> createState() => _UserTypeScreenBodyState();
}

class _UserTypeScreenBodyState extends State<_UserTypeScreenBody> {
  final TextEditingController codeControllerOne = TextEditingController();
  UserType _userType = UserType.user;

  @override
  void dispose() {
    super.dispose();
    codeControllerOne.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.tr(LocaleKeys.auth_select_user_type),
            style: TextStyles.bold16(),
          ).marginBottom(60).marginTop(context.deviceHeight * 0.28),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UserTypeCard(
                value: UserType.user,
                selectedUserType: _userType,
                onClick: _changeSelection,
              ),
              UserTypeCard(
                value: UserType.worker,
                selectedUserType: _userType,
                onClick: _changeSelection,
              )
            ],
          ),
          const Spacer(),
          AppButton(
            fontSize: 14.sp,
            text: LocaleKeys.action_next.tr(),
            onClick: _openLoginScreen,
          )
              .marginStart(16.w)
              .marginEnd(16.w)
              .marginBottom(context.deviceHeight * 0.17),
        ],
      ),
    );
  }

  void _changeSelection(UserType type) {
    setState(() {
      _userType = type;
    });
  }

  void _openLoginScreen() {
    Nav.pushReplacement(LoginScreen(
      userType: _userType,
    ));
  }
}
